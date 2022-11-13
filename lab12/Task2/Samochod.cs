using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq.Mapping;
using System.Data.Linq;

namespace Zad2
{
    [Table(Name = "Samochod")]
    class Samochod
    {
        private int _ID;
        private int _IDMarka;
        private String _Kolor;
        private EntityRef<Marka> _Marka;
        [Association(Storage = "_Marka", ThisKey = "IDMarka", OtherKey = "ID")]
        public Marka Marka
        {
            set
            {
                _Marka.Entity = value;
            }
            get
            {
                return _Marka.Entity;
            }
        }
        [Column(Name = "ID", Storage = "_ID", DbType = "int NOT NULL IDENTITY", IsPrimaryKey = true, IsDbGenerated = true)]
        public int ID
        {
            get { return _ID; }
            set { _ID = value; }
        }
        [Column(Name = "IDMarka", Storage = "_IDMarka", DbType = "int NOT NULL")]
        public int IDMarka
        {
            get { return _IDMarka; }
            set { _IDMarka = value; }
        }
        [Column(Name = "Kolor", Storage = "_Kolor", DbType = "nvarchar(30)")]
        public String Kolor
        {
            get { return _Kolor; }
            set { _Kolor = value; }
        }
        public override String ToString()
        {
            return "[" + ID + "] " + Kolor + " " + Marka.Nazwa;
        }
    }
}