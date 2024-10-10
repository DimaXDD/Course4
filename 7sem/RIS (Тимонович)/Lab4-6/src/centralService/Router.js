var express = require('express');
const { dbService } = require('./DBService.js');
var router = express.Router();

router.get('/', (req, res) => {
  res.json({ status: 'statusRouter' });
});

router.get('/time', (req, res) => {
  const unixEpoch = new Date(1970, 0, 1);
  const seconds = (Date.now() - unixEpoch.getTime()) / 1000;

  res.json({ time: seconds });
});

router.post('/replicate/:SUB', async (req, res) => {
  const { SUB } = req.params;

  try {
    // Получаем все данные из таблицы BODI
    const data = await dbService.getBODIAsync();

    // Получаем строки из таблицы N_TI для заданного SUB
    const IST = await dbService.getN_TIasync(SUB);

    // Проверяем, есть ли полученные значения IST
    if (!IST || IST.length === 0) {
      return res.status(200).json({});
    }

    // Извлекаем массив значений IST из полученных данных
    const istValues = IST.map((item) => item.IST); // Предполагаем, что item имеет свойство IST

    // Фильтруем data, оставляя только записи, у которых IST есть в istValues
    const filteredData = data.filter((item) => istValues.includes(item.IST)); // Предполагаем, что item имеет свойство IST

    // Возвращаем отфильтрованные данные
    res.json(filteredData);
  } catch (error) {
    console.error('Error in /replicate route:', error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
});

module.exports = router;
