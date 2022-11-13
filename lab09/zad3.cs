using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Collections.Generic;
using Microsoft.SqlServer.Server;
[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedAggregate(Format.Native)]
public struct uda_avg
{
    private SqlInt32 iNumRange;
    private double sum;
    public void Init()
    { 
        this.iNumRange = 0;
        this.sum = 0;
    }
    public void Accumulate(double Value)
    {
        this.sum += Value;
        this.iNumRange += 1;
    }
    public void Merge(uda_avg Group)
    { this.iNumRange += Group.iNumRange; }
    public double Terminate()
    {
        if (this.iNumRange == 0)
        {
            return 0;
        }
        return (sum/(double)this.iNumRange); 
    }
};
