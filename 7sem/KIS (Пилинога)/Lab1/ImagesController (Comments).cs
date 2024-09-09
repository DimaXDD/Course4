using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using Azure.Storage.Sas;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;

namespace Api.Controllers
{
    [ApiController]
    [Route("/")]
    public class ImagesController : ControllerBase
    {
        private HttpClient _httpClient; // HTTP клиент для отправки запросов
        private Options _options; // В данном случае, в настройках будет строка подключения к Azure Blob Storage

        public ImagesController(HttpClient httpClient, Options options)
        {
            _httpClient = httpClient;
            _options = options;
        }

        // Метод для получения клиента контейнера в Azure Blob Storage
        private async Task<BlobContainerClient> GetCloudBlobContainer(string containerName)
        {
            // Используем строку подключения из настроек
            BlobServiceClient serviceClient = new BlobServiceClient(_options.StorageConnectionString);
            
            // Получаем клиента контейнера с именем containerName
            BlobContainerClient containerClient = serviceClient.GetBlobContainerClient(containerName);
            
            // Создаем контейнер, если он не существует
            await containerClient.CreateIfNotExistsAsync();
            return containerClient;
        }

        // Обрабатывает GET-запросы для получения списка изображений
        [Route("/")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<string>>> Get()
        {
            // Получаем клиента контейнера для изображений
            BlobContainerClient containerClient = await GetCloudBlobContainer(_options.FullImageContainerName);

            BlobClient blobClient; // Клиент для взаимодействия с каждым отдельным blob-файлом
            BlobSasBuilder blobSasBuilder; // Создает SAS-токен для временного доступа к файлу

            List<string> results = new List<string>(); // Список для хранения ссылок на изображения
            // Проходим по всем blob-файлам в контейнере
            await foreach (BlobItem blobItem in containerClient.GetBlobsAsync())
            {
                // Получаем клиента для конкретного blob-файла
                blobClient = containerClient.GetBlobClient(blobItem.Name);
                
                // Настраиваем SAS-токен для файла, который будет действителен 5 минут
                blobSasBuilder = new BlobSasBuilder()
                {
                    BlobContainerName = _options.FullImageContainerName,
                    BlobName = blobItem.Name,
                    ExpiresOn = DateTime.UtcNow.AddMinutes(5), // Время жизни токена 5 минут
                    Protocol = SasProtocol.Https // Доступ только по HTTPS
                };
                
                // Устанавливаем разрешение на чтение для SAS-токена
                blobSasBuilder.SetPermissions(BlobSasPermissions.Read);

                // Добавляем сгенерированную ссылку в список результатов
                results.Add(blobClient.GenerateSasUri(blobSasBuilder).AbsoluteUri);
            }
            Console.Out.WriteLine("Got Images");

            return Ok(results);
        }

        // Обрабатывает POST-запросы для загрузки изображений
        [Route("/")]
        [HttpPost]
        public async Task<ActionResult> Post()
        {
            // Читаем изображение из тела запроса
            Stream image = Request.Body;

            // Получаем клиента контейнера для изображений
            BlobContainerClient containerClient = await GetCloudBlobContainer(_options.FullImageContainerName);

            // Генерируем уникальное имя для файла на основе GUID
            string blobName = Guid.NewGuid().ToString().ToLower().Replace("-", String.Empty);
            
            // Получаем клиента для конкретного blob-файла с уникальным именем
            BlobClient blobClient = containerClient.GetBlobClient(blobName);
            
            // Загружаем изображение в Azure Blob Storage
            await blobClient.UploadAsync(image);
            
            // Возвращаем URI загруженного файла с кодом 201 Created
            return Created(blobClient.Uri, null);
        }
    }
}
