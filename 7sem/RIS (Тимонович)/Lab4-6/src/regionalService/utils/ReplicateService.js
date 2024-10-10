const log = require('./logger.js');
const axios = require('axios');
const dotenv = require('dotenv');
dotenv.config({ path: process.argv[2] || '.env' });
const { dbService } = require('./DBService.js');

class ReplicateService {
  constructor(url) {
    this.correction = 0;
    this.mainServerAddress = url ?? 'http://192.168.43.100:3001';
  }

  fetchCentralBODIasync = async () => {
    try {
      const response = await axios.post(
        `${this.mainServerAddress}/api/replicate/${process.env.SUB}`
      );

      if (response.status !== 200) {
        throw new Error(
          `TimeService | syncTime | ERROR : status ${response.status} `
        );
      }
      const newData = response.data;
      /*
      Добавить запись о полученныз данных в BODK
      */
      if (newData.length > 0) {
        const existingData = await dbService.getBODIasync();

        // Фильтруем новые данные, чтобы оставить только те, которые отсутствуют в БД
        const filteredData = newData.filter(({ IST, DATV_SET }) => {
          const newIST = String(IST);
          const newDATV_SET = new Date(DATV_SET).getTime(); // Приведение даты к таймстампу для сравнения

          return !existingData.some((existingItem) => {
            const existingIST = String(existingItem.IST);
            const existingDATV_SET = new Date(existingItem.DATV_SET).getTime();

            // Сравниваем значения после приведения к единому формату
            return existingIST === newIST && existingDATV_SET === newDATV_SET;
          });
        });

        console.log('filteredData', filteredData);

        // Валидация данных перед вставкой
        const validatedData = filteredData.map((item) => {
          return {
            ...item,
            ZNC: Math.min(item.ZNC, 1e308),
          };
        });

        const groupedData = validatedData.reduce((groups, item) => {
          const key = `${item.IST}-${item.SUB.trim()}`;
          if (!groups[key]) {
            groups[key] = [];
          }
          groups[key].push(item);
          return groups;
        }, {});

        for (const [key, group] of Object.entries(groupedData)) {
          const [ist, sub] = key.split('-');
          dbService.setBODKAsync({ IST: ist, SUB: sub, KZAP: group.length });
        }

        await dbService.setBODIasync(filteredData);
      }
      log.info('fetchCentralBODIasync | OK');
    } catch (error) {
      console.log(error.message);
      log.error(error.message);
    }
  };
}

/*
по факту тут надо как то сделать работу с множеством центральынх серверов, можно сделать 
если выкидывает ошибку подклчбюения в блоке трай перебор существующих и доступных серверов
*/

const replicateService = new ReplicateService();

module.exports = { replicateService };
