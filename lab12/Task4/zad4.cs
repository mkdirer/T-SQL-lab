using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

namespace ConsoleApplication1
{

    class Task4
    {
        static void Main(string[] args)
        {
            XDocument xml_temp = XDocument.Load(@"C:\Users\Administrator\Desktop\pracownicy.xml");

            var query = from o in xml_temp.Descendants("osoba") join io in xml_temp.Descendants("idosoba") on (int)o.Element("id") equals (int)io.Attribute("id")
                        where io.Attribute("rok").Value == "2004" select new { Kwota = io.Attribute("zarobki_roczne").Value, Rok = io.Attribute("rok").Value };

            foreach (var q in query) Console.WriteLine(q);
        }
    }
}
