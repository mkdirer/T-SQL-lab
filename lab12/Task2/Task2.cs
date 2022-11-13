using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq;

namespace ConsoleApplication1
{
    class Task2
    {
        static void Main(string[] args)
        {
            String connString = @"
                Data Source=.;
                Initial Catalog=Samochody;
                Integrated Security=True";
            DataContext sDataContext = new DataContext(connString);
            Table<Samochod> Samochody = sDataContext.GetTable<Samochod>();
            if (sDataContext.DatabaseExists())
            {
                Console.WriteLine("Deleting old database...");
                sDataContext.DeleteDatabase();
            }
            sDataContext.CreateDatabase()
            Samochod samochod = new Samochod() {ID = 1, IDMarka = 1, Kolor = "Zielony" };
            Samochody.InsertOnSubmit(samochod);
            sDataContext.SubmitChanges();
        }
    }
}