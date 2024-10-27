using lab5;
using System;
using System.ServiceModel;

namespace Host
{
    internal class Program
    {
        static void Main()
        {
            var host = new ServiceHost(typeof(WCFSiplex));
            host.Open();
            Console.WriteLine("Service has been started");
            Console.ReadLine();
        }
    }
}
