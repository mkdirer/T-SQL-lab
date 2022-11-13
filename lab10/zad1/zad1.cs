using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;

public partial class Triggers{
    [Microsoft.SqlServer.Server.SqlTrigger (Name="udt_Trigger", Target="test1", Event="FOR INSERT")]
    public static void udt_Trigger(){
        using (SqlConnection oConn = new SqlConnection("context connection=true")){
            oConn.Open();
            string comment = "INSERT INTO info (user, content)" +
            "VALUES(USER, (SELECT CAST(item as VARCHAR(60)) FROM INSERTED))";
            SqlCommand sqlComm = new SqlCommand(comment, oConn);
            sqlComm.ExecuteNonQuery();
        }
    }
}
