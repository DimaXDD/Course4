using System.ServiceModel;

namespace lab5
{
    // ПРИМЕЧАНИЕ. Команду "Переименовать" в меню "Рефакторинг" можно использовать для одновременного изменения имени интерфейса "IWCFSiplex" в коде и файле конфигурации.
    [ServiceContract]
    public interface IWCFSiplex
    {
        [OperationContract]
        int Add(int x, int y);

        [OperationContract]
        string Concat(string s, double d);

        [OperationContract]
        A Sum(A a1, A a2);
        // TODO: Добавьте здесь операции служб
    }

    // Используйте контракт данных, как показано в примере ниже, чтобы добавить составные типы к операциям служб.
    // В проект можно добавлять XSD-файлы. После построения проекта вы можете напрямую использовать в нем определенные типы данных с пространством имен "lab5.ContractType".
   
}
