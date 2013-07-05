using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.IO;
using Microsoft.SqlServer.Server;

namespace AnjLab.FX.SQLServer.Udf
{
    [Serializable]
    [SqlUserDefinedAggregate(
        Format.UserDefined, 
        IsInvariantToDuplicates = true,
        IsInvariantToOrder = true, 
        IsNullIfEmpty = true,
        MaxByteSize = 8000)]
    public class Median : IBinarySerialize
    {
        protected List<string> _names;
        //  Key is the Value
        protected IDictionary<int, Pair> _values;

        public void Merge(Median value)
        {
            foreach (var pair in value._values.Values)
            {
                AddPair(pair);
            }
        }

        protected void AddPair(Pair pair)
        {
            if (!_names.Contains(pair.Name.Value))
            {
                _names.Add(pair.Name.Value);
            }
            pair.NameIndex = _names.IndexOf(pair.Name.Value);

            if (!_values.ContainsKey(pair.Value.Value))
            {
                _values.Add(pair.Value.Value, pair);
            }
            else
            {
                _values[pair.Value.Value].AddValueCount(pair.ValueCount.Value);
            }
        }

        public SqlString Terminate()
        {
            if (_values.Count == 0)
            {
                return SqlString.Null;
            }
            
            var keys = new List<int>(_values.Keys);
            keys.Sort();

            if (_values.Count == 1)
            {
                return new SqlString(_values[keys[0]].Name.Value);
            }

            int leftIdx = 0;
            int rightIdx = keys.Count - 1;

            int leftSum = _values[keys[leftIdx]].ValueCount.Value;
            int rightSum = _values[keys[rightIdx]].ValueCount.Value;

            while (leftIdx < rightIdx - 1)
            {
                if (leftSum > rightSum)
                {
                    rightSum += _values[keys[--rightIdx]].ValueCount.Value;
                }
                else if (leftSum <= rightSum)
                {
                    leftSum += _values[keys[++leftIdx]].ValueCount.Value;
                }
            }

            //  Wins who have greater sum. If sums are equal then two wins

            if (leftSum > rightSum)
            {
                return new SqlString(_values[keys[leftIdx]].Name.Value);
            }

            if (leftSum < rightSum)
            {
                return new SqlString(_values[keys[rightIdx]].Name.Value);
            }

            return new SqlString(_values[keys[leftIdx]].Name.Value + " - " + _values[keys[rightIdx]].Name.Value);
        }

        public void Init()
        {
            _values = new Dictionary<int, Pair>();
            _names = new List<string>();
        }

        public void Accumulate(Pair pair)
        {
            if (pair.IsNull || pair.Value.IsNull)
            {
                return;
            }
            AddPair(pair);
        }

        public void Read(BinaryReader r)
        {
            int size = r.ReadInt32();
            _names = new List<string>(size);
            for (int i = 0; i < size; i++)
            {
                _names.Add(r.ReadString());
            }

            size = r.ReadInt32();
            _values = new Dictionary<int, Pair>(size);
            for (int i = 0; i < size; i++)
            {
                var key = r.ReadInt32();
                var pair = new Pair {Value = key, ValueCount = r.ReadInt32(), NameIndex = r.ReadInt32()};
                pair.Name = _names[pair.NameIndex.Value];
                _values.Add(key, pair);
            }
        }

        public void Write(BinaryWriter w)
        {
            w.Write(_names.Count);
            foreach (var name in _names)
            {
                w.Write(name);
            }

            w.Write(_values.Count);
            foreach (var value in _values)
            {
                w.Write(value.Key);
                w.Write(value.Value.ValueCount.Value);
                w.Write(value.Value.NameIndex.Value);
            }
        }
    }
}