const { Database } = require('../../database/DB');
const dotenv = require('dotenv');
dotenv.config({ path: process.argv[2] || '.env' });
const log = require('./logger.js');

class DBService {
  constructor(db) {
    this.db = db;
  }

  setBODIasync = async (bodiData) => {
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
          DATV: new Date(),
          DATV_SET: data.DATV_SET,
          ZNC: data.KZAP,
        };

        await this.db.insertIntoBODI(formattedData);
      }
      return 1;
    } catch (e) {
      log.error(`DBService | setBODIasync | ${e}`);
    } finally {
      return null;
    }
  };

  getBODIasync = async () => {
    const result = await this.db.getFromBODI();

    return result;
  };

  setBODKAsync = async (data) => {
    try {
      const formattedData = {
        IST: data.IST,
        SUB: data.SUB,
        DATV_SET: data.DATV_SET || new Date(),
        KZAP: data.KZAP,
      };

      console.log('formattedData', formattedData);

      await this.db.insertIntoBODK(formattedData);

      return 1;
    } catch (e) {
      console.log(`setBODIasync | ${e.message}`);
    } finally {
      return null;
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

module.exports = { dbService };
