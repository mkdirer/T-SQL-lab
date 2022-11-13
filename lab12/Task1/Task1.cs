using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConsoleApplication1
{
    class Task1
    {
        static void Main(string[] args)
        {
            List<Samochod> samochody = new List<Samochod> { new Samochod() { ID = 1, IDMarka = 1, Kolor = "Czarny" }, new Samochod() { ID = 2, IDMarka = 2, Kolor = "Niebieski" } };
            List<Marka> marki = new List<Marka> { new Marka { ID = 1, Nazwa = "Fiat" }, new Marka { ID = 2, Nazwa = "BMW" } };

            var query1 = (from m in marki select m.Nazwa).Count();
            Console.WriteLine(query3);
            bool query2 = (from s in samochody select s.ID).Contains(2);
            Console.WriteLine(query2);
            var query3 = (from s in samochody select s.IDMarka).Max();
            Console.WriteLine(query3);
  
        }
    }
}
