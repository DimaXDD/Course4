## Чтобы было максимально понятно, буду писать объяснения по пунктам, как они и прописаны в лабе

### TODO:
1) Создаем проект типа Веб-приложение ASP.NET (.NET Framework)<br/>
Далее выбираем пустой шаблон<br/>
Жмем на проект ПКМ -> Добавить -> Создать элемент -> Веб-службы (ASMX), пишем имя файла `Simplex.asmx`<br/>
2) и 3) - [WSDL](https://www.w3.org/TR/2001/NOTE-wsdl-20010315), [SOAP 1.1](https://www.w3.org/TR/2000/NOTE-SOAP-20000508/), [SOAP 1.2](https://www.w3.org/TR/soap12-part1/)<br/>
4) Заходим в `Simplex.asmx` и прописываем<br/>
```
/// <summary>
    /// Сводное описание для Simplex
    /// </summary>
    [WebService(Namespace = "http://tds/", Description = "<h1>Lab4 by DimaXDD</h1>")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Чтобы разрешить вызывать веб-службу из скрипта с помощью ASP.NET AJAX, раскомментируйте следующую строку. 
    [System.Web.Script.Services.ScriptService]
    public class Simplex : System.Web.Services.WebService
    {

    }
```
Думаю тут понятно, что и для чего прописано<br/>
### Один момент, лучше сразу залить ASMX-сервис на IIS (хоть в лабе не сказано, но так нужно kekw) ) - у меня залито на http://localhost:7654
5), 6), 7), 8) - Просто смотрим файл `Simplex.asmx` и разбираем его<br/>
9) Здесь и далее, буду показывать на своем примере, думаю поймете :)<br/>
Запускаем наш проект, где находится файл `Simplex.asmx`<br/>
И переходим на `https://localhost:44380/Simplex.asmx` либо по IIS `http://localhost:7654/Simplex.asmx`<br/>
Если все хорошо, то будем видеть это<br/>
![task9](https://github.com/DimaXDD/Course4/tree/master/7sem/%D0%9FWS%20(%D0%A1%D0%BC%D0%B5%D0%BB%D0%BE%D0%B2)/Lab4/images/task9.png)
10) Просто проверяем методы `Add ` и `Concat` либо просто через запуск проекта, либо IIS<br/>
11) Создаем WinForm приложение, далее жмем ПКМ на проект -> Добавить -> Ссылка на службу<br/>
Прописываем путь к службе, которая у нас на IIS - `http://localhost:7654/Simplex.asmx` и нажимаем Перейти<br/>
После видим нашу службу, жмем на нее и нажимаем Ок
Запускаем форму и радуемся
12) Переходим на `http://localhost:7654/Simplex.asmx?WSDL` и рассказываем<br/>
13) Переходим, к примеру, по адресу `http://localhost:7654/Simplex.asmx?op=Add` и показываем запросы<br/>
14) Экспортируем из моего файла коллекцию запросов, меняем порты и прочее на свое и радуемся<br/>
15) и 16) Алгоритм одинаков - заходим с помощью командной строки в нашей IDE в наш проект и пишем команду `wsdl.exe http://localhost:7654/Simplex.asmx?WSDL`<br/>
Это создаст наш Proxy-class `Simpler.cs`<br/>
Дальше просто смотрим код и раазбираемся, по факту проекты работают не от службы, а то прокси класса
17) и 18) В стартовом проекте делаем папку `script`, создаем файлы и перезаливаем проект на IIS<br/>
Это делается для избежания политики CORS<br/>
Запускаем html-документ с IIS и радуемся жизни (`http://localhost:7654/script/index.html`)