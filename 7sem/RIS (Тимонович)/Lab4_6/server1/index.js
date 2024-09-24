const express = require('express');
const configuration = require('../configuration');
const logger = require('./utils/logger');
const router = require('./routes/router');
const generator = require('./services/generateService')
const syncronator = require('./services/syncTimeService')

// Подключение Prisma клиента
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const app = express();

const studentNumber = configuration.LOCAL_SERVER_1.STUDENT_NUMBER;
const PORT = configuration.LOCAL_SERVER_1.PORT

app.use(express.json());

app.use('/', router);

setInterval(() => {
    generator.generateModelData(studentNumber);
    console.log('Генерация данных...');
}, 5000);

async function startServer() {
    try {
        await prisma.$connect();
        logger.info('Подключено к базе данных');
        logger.info(`Сервер работает на порту ${PORT}`);

        let synced = false;
        while (!synced) {
            try {
                await syncronator.syncTime(configuration);
                logger.info(`Время успешно синхронизовано.`);
                synced = true;
            } catch (error) {
                logger.error(`Ошибка синхронизации времени: ${error}`);
                await wait(5000);
            }
        }
        
    } catch (error) {
        logger.error('Не удалось подключиться к базе данных:', error);
        process.exit(1);
    }
}

function wait(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

startServer();

app.listen(PORT);