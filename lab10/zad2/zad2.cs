using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Transactions;

public partial class StoredProcedures{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void SimpleTransactionScope(){
        TransactionScope oTran = new TransactionScope();
        using (SqlConnection oConn = new SqlConnection ("context connection=true;")){
            try{
                oConn.Open();
                SqlCommand oCmd = new SqlCommand("INSERT INTO employee VALUES (1, 'Adam', 'Jarosz')", oConn);
                oCmd.ExecuteNonQuery();
                oCmd.CommandText = "INSERT INTO task VALUES (1, 'Testing')";
                oCmd.ExecuteNonQuery();
                oCmd.CommandText = "INSERT INTO employee_task VALUES (1, 1)";
                oCmd.ExecuteNonQuery();
            }catch (SqlException ex){
                SqlContext.Pipe.Send(ex.Message.ToString());
            }finally{
                oTran.Complete();
                oConn.Close();
            }
        }

        oTran.Dispose();
    }
};
