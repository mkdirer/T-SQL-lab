using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Task3
{
    class Task3BD2
    {
        static void Main(string[] args)
        {
            string sqlconnection = @"DATA SOURCE=MSSQLServer;" +
            "INITIAL CATALOG=Lab6db; INTEGRATED SECURITY=SSPI;";
            SqlConnection connection = new SqlConnection(sqlconnection);
            try
            {
                connection.Open();
                string create_databases_query = "EXEC task2";
                SqlCommand command = new SqlCommand(create_databases_query, connection);
                command.ExecuteNonQuery();

                // wprowadzenie danych, wersja bez csv
                string task3b = @"INSERT INTO wykladowca (id, fname, lname) VALUES (1, 'Kamil', 'Hajnold');
	                INSERT INTO wykladowca (id, fname, lname) VALUES (2, 'Mikołaj', 'Jutro');
	                INSERT INTO wykladowca (id, fname, lname) VALUES (3, 'Jan', 'Fidelski');
	                INSERT INTO wykladowca (id, fname, lname) VALUES (4, 'Michał', 'kasprzak');
					INSERT INTO student (id, fname, lname) VALUES (1, 'Aleksandra', 'Mroń'); 
                    INSERT INTO student (id, fname, lname) VALUES (2, 'Teresa', 'Jagodzińska');
	                INSERT INTO student (id, fname, lname) VALUES (3, 'Ula', 'Borek');
					INSERT INTO przedmiot (id, name) VALUES (1, 'Bazy Danych II');
	                INSERT INTO przedmiot (id, name) VALUES (2, 'Inżynieria Oprogramowania');
	                INSERT INTO przedmiot (id, name) VALUES (3, 'Grafy i ich zastosowania');
	                INSERT INTO przedmiot (id, name) VALUES (4, 'Metody numeryczne');
	                INSERT INTO grupa (id_wykl, id_stud, id_przed) VALUES (1,1,1);
	                INSERT INTO grupa (id_wykl, id_stud, id_przed) VALUES (2,2,2);
	                INSERT INTO grupa (id_wykl, id_stud, id_przed) VALUES (3,3,3);
	                INSERT INTO grupa (id_wykl, id_stud, id_przed) VALUES (1,2,1);
	                INSERT INTO grupa (id_wykl, id_stud, id_przed) VALUES (2,1,2);
	                INSERT INTO grupa (id_wykl, id_stud, id_przed) VALUES (3,1,3);
	                INSERT INTO grupa (id_wykl, id_stud, id_przed) VALUES (3,2,3);
                ";
                command = new SqlCommand(task3b, connection);
                command.ExecuteNonQuery();


                // wykonanie zapytania
                string studWykladowca = @"
                SELECT wykladowca.fname, wykladowca.lname, COUNT(student.id) AS num_stud FROM grupa
	                JOIN student ON student.id = grupa.id_stud
	                JOIN wykladowca ON wykladowca.id = grupa.id_wykl
	                GROUP BY wykladowca.fname, wykladowca.lname
                ";

                Console.WriteLine("Liczba studentow dla kazdego wykladowcy:\n");

                command = new SqlCommand(studWykladowca, connection);
                SqlDataReader datareader = command.ExecuteReader();
                while (datareader.Read())
                {
                    Console.WriteLine("{0}\t{1}\t{2}",
                    datareader["fname"].ToString(),
                    datareader["lname"].ToString(),
                    datareader["num_stud"].ToString());
                }
                datareader.Close();
                Console.WriteLine("\n");

                string studKurs = @"
                SELECT przedmiot.name, COUNT(student.id) AS num_stud FROM grupa
	                JOIN student ON student.id = grupa.id_stud
	                JOIN przedmiot ON przedmiot.id = grupa.id_przed
	                GROUP BY przedmiot.name
                ";

                Console.WriteLine("Liczba studentow dla kazdego kursu:\n");

                command = new SqlCommand(studKurs, connection);
                datareader = command.ExecuteReader();
                while (datareader.Read())
                {
                    Console.WriteLine("{0}\t{1}\t",
                    datareader["name"].ToString(),
                    datareader["num_stud"].ToString());
                }
                Console.WriteLine("\n");
            }
            catch (SqlException ex)
            { Console.WriteLine(ex.Message); }
            finally
            { connection.Close(); }
            Console.Write("Press any key...");
            Console.ReadKey();
        }
    }
}