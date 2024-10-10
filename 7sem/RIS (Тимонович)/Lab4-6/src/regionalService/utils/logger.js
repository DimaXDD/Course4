const winston = require('winston');
const dotenv = require('dotenv').config({ path: process.argv[2] || '.env' });

class Logger {
  createLogger(
    filename = `RegionalServer${process.env.PORT || 'default'}.log`
  ) {
    return winston.createLogger({
      level: 'info',
      format: winston.format.json(),
      transports: [
        new winston.transports.File({ filename }),
        // new winston.transports.Console(),
      ],
    });
  }
}

const logger = new Logger().createLogger();

module.exports = logger;
