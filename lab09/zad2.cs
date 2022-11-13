using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedAggregate(Format.Native)]
public struct uda_CountDivisibleBy3
{
    private SqlInt32 iNumRange;
    public void Init()
    { this.iNumRange = 0; }
    public void Accumulate(SqlInt32 Value)
    {
        if (Value % 3 == 0)
        { this.iNumRange += 1; }
    }
    public void Merge(uda_CountDivisibleBy3 Group)
    { this.iNumRange += Group.iNumRange; }
    public SqlInt32 Terminate()
    { return ((SqlInt32)this.iNumRange); }
};