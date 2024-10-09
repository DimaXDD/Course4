const axios = require('axios');
const log = require('./logger.js');
const { Database } = require('../database/DB.js');
const dotenv = require('dotenv');
dotenv.config({ path: process.argv[2] || '.env' });
const { Op } = require('sequelize');

/*
Добавить взаимодействие с таблицой BODK для синхронизации
контрольной информации(какие строки из таблицы BODI уже
синхронизированны, а какие ещё надо синхронизировать) 
*/

class DBService {
  constructor(db) {
    this.db = db;
    this.db.connect();
  }

  pingStatusServicesAsync = async () => {
    try {
      const data = await this.db.getFromT_SUB('regional');

      if (data) {
        for (const elem of data) {
          try {
            const serviceUrl = `http://${elem.SUB_ADR}:${elem.SUB_PORT.trim()}`;

            let response;
            try {
              response = await axios.head(`${serviceUrl}/api/status`);
            } catch (e) {
              log.error(`Request to ${serviceUrl} failed: ${e.message}`);
            }

            if (response) {
              await this.db.updateACT(elem.SUB, 1);
              log.info(
                `Response from ${serviceUrl}: ${response.headers['x-status']}`
              );
            } else {
              await this.db.updateACT(elem.SUB, 0);
              log.info(`No response from ${serviceUrl}`);
            }
          } catch (error) {
            log.error(`Error processing ${elem.SUB}: ${error.message}`);
          }
        }
      }
    } catch (error) {
      log.error(`pingStatusServicesAsync: ${error.message}`);
    } finally {
    }
  };

  getRegionalBODIAsync = async () => {
    try {
      const TELEMEASUREMENT_SERVICES = new Set();

      //опрос ТО которые в сети
      const data = await this.db.getFromT_SUB({
        where: {
          ACT: '1',
        },
      });

      for (const elem of data) {
        TELEMEASUREMENT_SERVICES.add(
          `http://${elem.SUB_ADR}:${elem.SUB_PORT.split(' ')[0]}`
        );
      }

      for (const serviceUrl of TELEMEASUREMENT_SERVICES) {
        try {
          const response = await axios.post(`${serviceUrl}/api/replicate`);

          this.setBODIAsync(response.data);

          log.info(`getRegionalBODIasync | Response from ${serviceUrl}`);
        } catch (error) {
          log.error(`Error polling ${serviceUrl}: ${error.message}`);
        }
      }
    } catch (e) {
      log.error(`Error getRegionalBODIasync`);
    } finally {
    }
  };

  getBODIAsync = async () => {
    try {
      const result = await this.db.getFromBODI();

      return result;
    } catch (e) {
      console.error(e);
    } finally {
    }
  };

  setBODIAsync = async (bodiData) => {
    try {
      for (const data of bodiData) {
        const formattedData = {
          IST: data.IST,
          SUB: data.SUB,
          TABL: data.TABL,
          POK: data.POK,
          VID: data.VID,
          PER: data.PER,
          PP: data.PP,
          UT: data.UT,
          OTN: data.OTN,
          OBJ: data.OBJ,
          ZNC: data.KZAP,
        };

        await this.db.insertIntoBODI(formattedData);
      }
      return 1;
    } catch (e) {
      console.log(`setBODIasync | ${e}`);
    } finally {
      return null;
    }
  };

  getN_TIasync = async (SUB_R) => {
    try {
      const result = await this.db.getFromN_TI({
        where: {
          SUB_R: {
            [Op.like]: `%${SUB_R}%`,
          },
        },
      });

      return result;
    } catch (e) {
      console.error(e);
    } finally {
    }
  };
}

const database = new Database(
  process.env.DB_HOST,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  process.env.DB_NAME
);

const dbService = new DBService(database);

module.exports = {
  dbService,
};
