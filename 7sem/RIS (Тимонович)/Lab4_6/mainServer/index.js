const express = require('express');
const logger = require('./utils/logger');
const router = require('./routes/router');
const configuration = require('../configuration');
const replicator = require('./services/replicationService')

// Подключение Prisma клиента
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const app = express();

app.use('/', router);

const PORT = configuration.MAIN_SERVER.PORT

app.use(express.json());

setInterval(async () => {
    console.log('Выталкивающая синхронизация данных...');
    await replicator.pushReplication(configuration);
    console.log('Вытягивающая синхронизация данных...');
    await replicator.pullReplication(configuration);
}, 10000);


app.listen(PORT, async () => {
    try {
        await prisma.$connect();
        logger.info('Подключено к базе данных');

        logger.info(`Сервер работает на порту ${PORT}`);
    } catch (error) {
        logger.error('Не удалось подключиться к базе данных:', error);
        process.exit(1);
    }
});