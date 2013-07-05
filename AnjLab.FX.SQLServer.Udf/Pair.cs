using System;
using System.Data.SqlTypes;
using System.IO;
using Microsoft.SqlServer.Server;

namespace AnjLab.FX.SQLServer.Udf
{
    [Serializable]
    [SqlUserDefinedType(Format.UserDefined, MaxByteSize = 8000)]
    public class Pair : INullable, IComparable<Pair>, IBinarySerialize
    {
        public SqlInt32 Value { get; set; }
        public SqlString Name { get; set; }
        public SqlInt32 NameIndex { get; set; }
        public SqlInt32 ValueCount { get; set; }

        private bool _null;

        public Pair()
        {
            _null = false;
            ValueCount = 1;
        }

        public void AddValueCount(int count)
        {
            ValueCount += count;
        }

        public int CompareTo(Pair other)
        {
            return Value.Value.CompareTo(other.Value.Value);
        }

        public override string ToString()
        {
            return Value.Value + "=" + Name.Value;
        }

        public bool IsNull
        {
            get
            {
                return _null;
            }
        }

        public static Pair Null
        {
            get
            {
                return new Pair { _null = true };
            }
        }

        public static Pair Parse(SqlString s)
        {
            if (s.IsNull)
            {
                return Null;
            }
            var u = new Pair();
            string[] parts = s.Value.Split('=');
            u.Value = int.Parse(parts[0]);
            u.Name = parts[1];
            return u;
        }

        public void Read(BinaryReader r)
        {
            _null = r.ReadBoolean();
            Value = r.ReadInt32();
            Name = r.ReadString();
        }

        public void Write(BinaryWriter w)
        {
            w.Write(_null);
            w.Write(Value.Value);
            w.Write(Name.Value);
        }
    }
}