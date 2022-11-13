using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;


public partial class StoredProcedures{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void task1(SqlString pattern){
        SqlConnection connection = new SqlConnection("context connection=true");

        connection.Open();

        SqlCommand command = new SqlCommand(
            @"SELECT e.EmployeeID, ad_p.AddressLine1
                FROM HumanResources.Employee e
	            JOIN HumanResources.EmployeeAddress ad_e ON e.EmployeeID = ad_e.EmployeeID
	            JOIN Person.Address ad_p ON ad_e.AddressID = ad_p.AddressID
            ;",
            connection
        );

        SqlDataReader reader = command.ExecuteReader();

        while (reader.Read()){
            if (reader["AddressLine1"].ToString().Contains(pattern.ToString())){
                SqlContext.Pipe.Send(reader["EmployeeID"].ToString() + ", " + reader["AddressLine1"].ToString());
            }
        }
    }
};