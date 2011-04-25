using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

namespace AnjLab.FX.SQLServer.Udf
{
    public class UserDefinedFunctions
    {
        [SqlFunction]
        public static Pair MakePair(SqlInt32 value, SqlString name)
        {
            if (value.IsNull) return Pair.Null;

            var pair = new Pair {Value = value, Name = name};

            return pair;
        }
    };
}