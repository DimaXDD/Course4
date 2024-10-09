const log = require('./logger.js');
const axios = require('axios');
const dotenv = require('dotenv');
dotenv.config({ path: process.argv[2] || '.env' });
const { dbService } = require('./DBService.js');

class ReplicateService {
  constructor(url) {
    this.correction = 0;
    this.mainServerAddress = url ?? 'http://192.168.0.103:3001';
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

      dbService.setBODIasync(response.data);
      log.info('fetchCentralBODIasync | OK');
    } catch (error) {
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
