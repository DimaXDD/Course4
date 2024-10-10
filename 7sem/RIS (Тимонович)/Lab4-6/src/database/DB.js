const { Sequelize, DataTypes } = require('sequelize');

const formatDate = (date) => {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  const hours = String(date.getHours()).padStart(2, '0');
  const minutes = String(date.getMinutes()).padStart(2, '0');
  const seconds = String(date.getSeconds()).padStart(2, '0');

  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
};

// Форматирование временной метки для MSSQL
Sequelize.DATE.prototype._stringify = function _stringify(date, options) {
  return this._applyTimezone(date, options).format('YYYY-MM-DD HH:mm:ss.SSS');
};

class Database {
  constructor(ip, username, password, databaseName) {
    this.sequelize = new Sequelize(databaseName, username, password, {
      host: ip,
      dialect: 'mssql',
      logging: false,
    });

    // Определение таблицы BODI
    this.BODI = this.sequelize.define(
      'BODI',
      {
        IST: {
          type: DataTypes.CHAR(3),
          allowNull: false,
          defaultValue: '-',
          validate: {
            is: /^[0-9]{0,3}$/, // Валидатор для значений от 0 до 999
          },
          primaryKey: true, // Включаем в составной первичный ключ
        },
        TABL: {
          type: DataTypes.CHAR(5),
          allowNull: false,
          defaultValue: '-',
          primaryKey: true, // Включаем в составной первичный ключ
        },
        POK: {
          type: DataTypes.CHAR(4),
          allowNull: false,
          defaultValue: '-',
          primaryKey: true, // Включаем в составной первичный ключ
        },
        UT: {
          type: DataTypes.CHAR(2),
          allowNull: false,
          defaultValue: '00',
          validate: {
            is: /^[0-9]{0,2}$/, // Валидатор для значений от 0 до 99
          },
          primaryKey: true, // Включаем в составной первичный ключ
        },
        SUB: {
          type: DataTypes.CHAR(6),
          allowNull: false,
          defaultValue: '-',
          primaryKey: true, // Включаем в составной первичный ключ
        },
        OTN: {
          type: DataTypes.CHAR(2),
          allowNull: false,
          defaultValue: '00',
          primaryKey: true, // Включаем в составной первичный ключ
        },
        OBJ: {
          type: DataTypes.CHAR(16),
          allowNull: false,
          defaultValue: '0000000000000000',
          validate: {
            is: /^[0-9]{0,16}$/, // Валидатор для значений от 0 до 9999999999999999
          },
          primaryKey: true, // Включаем в составной первичный ключ
        },
        VID: {
          type: DataTypes.CHAR(2),
          allowNull: false,
          defaultValue: '-',
          primaryKey: true, // Включаем в составной первичный ключ
        },
        PER: {
          type: DataTypes.CHAR(2),
          allowNull: false,
          defaultValue: '-',
          primaryKey: true, // Включаем в составной первичный ключ
        },
        DATV: {
          type: DataTypes.DATE,
          allowNull: false,
          defaultValue: Sequelize.fn('GETDATE'), // Автоматическая установка даты и времени
        },
        DATV_SET: {
          type: DataTypes.DATE,
          allowNull: false,
          defaultValue: Sequelize.fn('GETDATE'), // Автоматическая установка даты и времени
          primaryKey: true,
        },
        ZNC: {
          type: DataTypes.FLOAT,
          allowNull: true,
        },
        PP: {
          type: DataTypes.CHAR(2),
          allowNull: true,
          defaultValue: null,
        },
      },
      {
        tableName: 'BODI',
        timestamps: false,
        indexes: [
          {
            unique: true,
            fields: [
              'IST',
              'TABL',
              'POK',
              'UT',
              'SUB',
              'OTN',
              'OBJ',
              'VID',
              'PER',
              'DATV_SET',
            ],
          },
        ],
      }
    );

    // Определение таблицы BODK
    this.BODK = this.sequelize.define(
      'BODK',
      {
        IST: {
          type: DataTypes.CHAR(3),
          allowNull: false,
          defaultValue: '-',
          primaryKey: true, // Включаем в составной первичный ключ
        },
        SUB: {
          type: DataTypes.CHAR(6),
          allowNull: false,
          defaultValue: '-',
          primaryKey: true, // Включаем в составной первичный ключ
        },
        DATV_SET: {
          type: DataTypes.DATE,
          allowNull: false,
          defaultValue: Sequelize.fn('GETDATE'), // Автоматическая установка даты и времени
          primaryKey: true, // Включаем в составной первичный ключ
        },
        KZAP: {
          type: DataTypes.SMALLINT,
          allowNull: false,
          defaultValue: 0,
          primaryKey: true, // Включаем в составной первичный ключ
        },
      },
      {
        tableName: 'BODK',
        timestamps: false,
        indexes: [
          {
            unique: true,
            fields: ['IST', 'SUB', 'DATV_SET', 'KZAP'],
          },
        ],
      }
    );

    // Определение таблицы N_TI
    this.N_TI = this.sequelize.define(
      'N_TI',
      {
        IST: {
          type: DataTypes.CHAR(3),
          allowNull: false,
          primaryKey: true, // Включаем в составной первичный ключ
        },
        TABL: {
          type: DataTypes.CHAR(5),
          allowNull: false,
          primaryKey: true, // Включаем в составной первичный ключ
        },
        POK: {
          type: DataTypes.CHAR(4),
          allowNull: false,
          primaryKey: true, // Включаем в составной первичный ключ
        },
        UT: {
          type: DataTypes.CHAR(2),
          allowNull: false,
        },
        SUB: {
          type: DataTypes.CHAR(6),
          allowNull: false,
          primaryKey: true, // Включаем в составной первичный ключ
        },
        OTN: {
          type: DataTypes.CHAR(2),
          allowNull: false,
          primaryKey: true, // Включаем в составной первичный ключ
        },
        OBJ: {
          type: DataTypes.CHAR(16),
          allowNull: false,
        },
        VID: {
          type: DataTypes.CHAR(2),
          allowNull: false,
        },
        PER: {
          type: DataTypes.CHAR(2),
          allowNull: false,
          primaryKey: true, // Включаем в составной первичный ключ
        },
        N_TI: {
          type: DataTypes.INTEGER,
          allowNull: false,
          defaultValue: 0,
        },
        SUB_R: {
          type: DataTypes.CHAR(6),
          allowNull: false,
          primaryKey: true, // Включаем в составной первичный ключ
        },
        NAME: {
          type: DataTypes.STRING(50),
          primaryKey: true, // Включаем в составной первичный ключ
        },
        ACT: {
          type: DataTypes.TINYINT,
          allowNull: false,
          defaultValue: 1,
        },
      },
      {
        tableName: 'N_TI',
        timestamps: false,
        primaryKey: [
          'IST',
          'TABL',
          'POK',
          'SUB',
          'OTN',
          'PER',
          'SUB_R',
          'NAME',
        ],
      }
    );

    // Определение таблицы T_IST
    this.T_IST = this.sequelize.define(
      'T_IST',
      {
        IST: {
          type: DataTypes.CHAR(3),
          allowNull: false,
        },
        PERIOD: {
          type: DataTypes.CHAR(3),
          allowNull: false,
        },
        ED: {
          type: DataTypes.CHAR(1),
          allowNull: false,
        },
        DT_BEG: {
          type: DataTypes.CHAR(2),
          allowNull: false,
        },
        DT_END: {
          type: DataTypes.CHAR(2),
          allowNull: false,
        },
      },
      {
        tableName: 'T_IST',
        timestamps: false,
        primaryKey: ['IST'],
      }
    );

    // Определение таблицы T_S_N
    this.T_S_N = this.sequelize.define(
      'T_S_N',
      {
        IST: {
          type: DataTypes.CHAR(3),
          allowNull: false,
        },
        SUB: {
          type: DataTypes.CHAR(6),
          allowNull: false,
        },
        S_N: {
          type: DataTypes.CHAR(1),
          allowNull: false,
        },
      },
      {
        tableName: 'T_S_N',
        timestamps: false,
        primaryKey: ['IST', 'SUB', 'S_N'],
      }
    );

    // Определение таблицы T_SUB
    this.T_SUB = this.sequelize.define(
      'T_SUB',
      {
        ACT: {
          type: DataTypes.CHAR(1),
          allowNull: false,
          defaultValue: '0',
        },
        SUB: {
          type: DataTypes.CHAR(6),
          allowNull: false,
          primaryKey: true, // Включаем в составной первичный ключ
        },
        SUB_NAME: {
          type: DataTypes.CHAR(5),
          allowNull: false,
          primaryKey: true, // Включаем в составной первичный ключ
        },
        WITH_PROXY: {
          type: DataTypes.CHAR(1),
          allowNull: false,
          defaultValue: 'N',
        },
        SUB_ADR: {
          type: DataTypes.STRING(50),
          allowNull: false,
        },
        SUB_PORT: {
          type: DataTypes.CHAR(5),
          allowNull: false,
          defaultValue: '80',
        },
        SUB_PROXY: {
          type: DataTypes.STRING(60),
        },
        SUB_PATH: {
          type: DataTypes.STRING(255),
          allowNull: false,
        },
        SUB_PROXY_PORT: {
          type: DataTypes.CHAR(5),
        },
      },
      {
        tableName: 'T_SUB',
        timestamps: false,
        indexes: [
          {
            unique: true,
            fields: ['SUB', 'SUB_NAME'],
          },
        ],
      }
    );
  }

  async connect() {
    try {
      await this.sequelize.authenticate();
      //console.log('Connection has been established successfully.');
    } catch (error) {
      console.error('Unable to connect to the database:', error);
    }
  }

  async disconnect() {
    try {
      await this.sequelize.close();
      //console.log('Connection has been closed successfully.');
    } catch (error) {
      console.error('Error closing the connection:', error);
    }
  }

  async insertIntoBODI(data) {
    try {
      const result = await this.BODI.create(data);
      return result;
    } catch (error) {
      console.error('Error inserting into BODI:', error);
    }
  }

  async getFromBODI(query = {}) {
    try {
      const result = await this.BODI.findAll(query);
      return result;
    } catch (error) {
      console.error('Error fetching from BODI:', error);
    }
  }

  async insertIntoBODK(data) {
    try {
      const result = await this.BODK.create(data);
      return result;
    } catch (error) {
      console.error('Error inserting into BODI:', error);
    }
  }

  async updateBODK_KZAP(data) {
    const query = `UPDATE BODK SET KZAP = ? WHERE IST = ? AND SUB = ? AND DATV_SET = ?`;
    const values = [data.KZAP, data.IST, data.SUB, data.DATV_SET];

    try {
      const result = await this.execute(query, values);
      return result;
    } catch (error) {
      console.error('Error updating KZAP in BODK:', error);
      throw error;
    }
  }

  async getFromBODK(query = {}) {
    try {
      const result = await this.execute('SELECT * FROM BODK WHERE ?', query); // Предполагая, что вы используете какой-то ORM или свой метод
      return result;
    } catch (error) {
      console.error('Error fetching from BODK:', error);
      throw error;
    }
  }

  async insertIntoN_TI(data) {
    try {
      const result = await this.N_TI.create(data);
      return result;
    } catch (error) {
      console.error('Error inserting into N_TI:', error);
    }
  }

  async getFromN_TI(query = {}) {
    try {
      const result = await this.N_TI.findAll(query);
      return result;
    } catch (error) {
      console.error('Error fetching from N_TI:', error);
    }
  }

  async insertIntoT_IST(data) {
    try {
      const result = await this.T_IST.create(data);
      return result;
    } catch (error) {
      console.error('Error inserting into T_IST:', error);
    }
  }

  async getFromT_IST(query = {}) {
    try {
      const result = await this.T_IST.findAll(query);
      return result;
    } catch (error) {
      console.error('Error fetching from T_IST:', error);
    }
  }

  async insertIntoT_S_N(data) {
    try {
      const result = await this.T_S_N.create(data);
      return result;
    } catch (error) {
      console.error('Error inserting into T_S_N:', error);
    }
  }

  async getFromT_S_N(query = {}) {
    try {
      const result = await this.T_S_N.findAll(query);
      return result;
    } catch (error) {
      console.error('Error fetching from T_S_N:', error);
    }
  }

  async insertIntoT_SUB(data) {
    try {
      const result = await this.T_SUB.create(data);
      return result;
    } catch (error) {
      console.error('Error inserting into T_SUB:', error);
    }
  }

  async getFromT_SUB(type) {
    try {
      let query = {};
      switch (type) {
        case 'regional':
        case 'central':
          query = {
            where: {
              SUB: {
                [Sequelize.Op.lt]: 101, // Находим все записи, где SUB > 100
              },
            },
          };
          break;
      }

      const result = await this.T_SUB.findAll(query);
      return result;
    } catch (error) {
      console.error('Error fetching from T_SUB:', error);
    }
  }

  async updateACT(sub, newACT) {
    try {
      const result = await this.T_SUB.update(
        { ACT: newACT },
        {
          where: { SUB: sub },
        }
      );

      return result;
    } catch (error) {
      console.error(`Error updating ACT for SUB: ${sub}`, error);
    }
  }
}

module.exports = {
  Database,
};
