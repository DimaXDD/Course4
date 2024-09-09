using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace Web.Pages
{
    // Модель страницы для Razor Pages
    public class IndexModel : PageModel
    {
        private HttpClient _httpClient; // HTTP клиент для отправки запросов к API
        private Options _options; // Параметры приложения, например, URL API

        // Конструктор, инициализирующий HttpClient и настройки приложения
        public IndexModel(HttpClient httpClient, Options options)
        {
            _httpClient = httpClient; // Инициализация HTTP клиента
            _options = options; // Инициализация параметров (например, URL API)
        }

        [BindProperty]
        public List<string> ImageList { get; private set; } // Список строк (ссылок на изображения), который будет привязан к странице

        [BindProperty]
        public IFormFile Upload { get; set; } // Загружаемый пользователем файл через форму

        // Метод, вызываемый при GET-запросе к странице
        public async Task OnGetAsync()
        {
            var imagesUrl = _options.ApiUrl; // Получаем URL API для получения изображений

            // Выполняем GET-запрос к API для получения списка изображений в формате JSON
            string imagesJson = await _httpClient.GetStringAsync(imagesUrl);

            // Десериализуем JSON в список строк (ссылок на изображения)
            IEnumerable<string> imagesList = JsonConvert.DeserializeObject<IEnumerable<string>>(imagesJson);

            // Преобразуем десериализованный список в List и сохраняем его в свойство ImageList
            this.ImageList = imagesList.ToList<string>();
        }

        // Метод, вызываемый при POST-запросе (при загрузке изображения)
        public async Task<IActionResult> OnPostAsync()
        {
            // Проверяем, что файл был загружен пользователем
            if (Upload != null && Upload.Length > 0)
            {
                var imagesUrl = _options.ApiUrl; // URL API для отправки изображений

                // Читаем загруженный файл как поток
                using (var image = new StreamContent(Upload.OpenReadStream()))
                {
                    // Устанавливаем тип контента для файла (например, image/jpeg)
                    image.Headers.ContentType = new MediaTypeHeaderValue(Upload.ContentType);

                    // Отправляем POST-запрос к API с загружаемым изображением
                    var response = await _httpClient.PostAsync(imagesUrl, image);
                }
            }
            // Перенаправляем пользователя обратно на страницу Index после загрузки изображения
            return RedirectToPage("/Index");
        }
    }
}
