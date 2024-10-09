const { Database } = require('../database/DB.js');

const SUB = [
  {
    db: new Database(
      '127.0.0.1',
      'sa',
      '1111',
      'TerritorialDatabase1'
    ),
    its: ['001', '002', '003'],
    sub: '101',
  },
  {
    db: new Database(
      '127.0.0.1',
      'sa',
      '1111',
      'TerritorialDatabase2'
    ),
    its: ['004', '005', '006'],
    sub: '102',
  },
  {
    db: new Database(
      '127.0.0.1',
      'sa',
      '1111',
      'TerritorialDatabase3'
    ),
    its: ['007', '008', '009'],
    sub: '103',
  },
];

(async () => {
  for (const sub of SUB) {
    await sub.db.connect();

    for (let i = 0; i < sub.its.length; i++) {
      // Изменили <= 3 на < sub.its.length
      let res = await sub.db.insertIntoBODI({
        IST: sub.its[i],
        TABL: `TAB01`,
        POK: `POK${i + 1}`,
        UT: '00',
        SUB: sub.sub,
        OTN: '00',
        OBJ: '0000000000000000',
        VID: '03',
        PER: '01',
        DATV: new Date(Date.now()).toISOString(),
        ZNC: 1.0,
        PP: '00',
      });

      // Здесь можно добавить обработку ответа от insertIntoBODI, если нужно
    }

    await sub.db.disconnect();
  }
})();
