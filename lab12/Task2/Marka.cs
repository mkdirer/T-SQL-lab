using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq.Mapping;
using System.Data.Linq;

namespace Zad2
{
    [Table(Name = "Marka")]
    class Marka
    {
        private int _ID;
        private String _Nazwa;
        [Column(Name = "ID", Storage = "_ID", DbType = "int NOT NULL IDENTITY", IsPrimaryKey = true, IsDbGenerated = true)]
        public int ID
        {
            get { return _ID; }
            set { _ID = value; }
        }
        [Column(Name = "Nazwa", Storage = "_Nazwa", DbType = "nvarchar(30)")]
        public String Nazwa
        {
            get { return _Nazwa; }
            set { _Nazwa = value; }
        }
        public override string ToString()
        {
            return "[" + ID + "] " + Nazwa;
        }
    }
}