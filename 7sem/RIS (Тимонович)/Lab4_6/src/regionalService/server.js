const express = require('express');
const { timeService } = require('./utils/TimeService.js');
const { replicateService } = require('./utils/ReplicateService.js');
const router = require('./Router.js');
const dotenv = require('dotenv');
const fs = require('fs');
const log = require('./utils/logger.js');

const envFile = process.argv[2] || '.env';

if (fs.existsSync(envFile)) {
  dotenv.config({ path: envFile });
} else {
  throw new Error(`Файл конфигурации ${envFile} не найден.`);
}

const PORT = process.env.PORT || 4000;
const app = express();

app.use(express.json());

app.use('/api', router(log));

app.listen(PORT, () => {
  log.info(`Региональный сервис запущен на порту: ${PORT}`);

  setInterval(() => {
    timeService.syncTime();
  }, 1000);
  setInterval(() => {
    replicateService.fetchCentralBODIasync();
  }, 3000);
});

//node .\src\regionalService\server.js t1.env
