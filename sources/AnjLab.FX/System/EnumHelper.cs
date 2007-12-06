﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using AnjLab.FX.Windows.Data;

namespace AnjLab.FX.System
{
    public class EnumHelper
    {
        private readonly Dictionary<Enum, EnumHelperPair> _pairs = new Dictionary<Enum, EnumHelperPair>();


        public EnumHelper()
        {
        }


        public EnumHelper(Enum[] enums, string[] values)
        {
            if(enums.Length != values.Length)
                throw new ArgumentException();

            for(int i=0; i<enums.Length; i++)
            {
                _pairs.Add(enums[i], new EnumHelperPair(enums[i], values[i]));
            }
        }

        public EnumHelperPair[] Pairs
        {
            get { return new List<EnumHelperPair>(_pairs.Values).ToArray(); }
            set
            {
                foreach (EnumHelperPair pair in value)
                {
                    _pairs.Add(pair.Enum, pair);
                }
            }
        }

        public Enum GetEnumValue(EnumHelperPair pair)
        {
            return pair.Enum;
        }

        public string GetStringValue(Enum eNum)
        {
            return _pairs[eNum].Value;
        }

        public EnumHelperPair GetPair(Enum eNum)
        {
            return _pairs[eNum];
        }
    }

    public class EnumHelperPair
    {
        private Enum _enum;
        private string _value;


        public EnumHelperPair()
        {
        }


        public EnumHelperPair(Enum eNum, string value)
        {
            _enum = eNum;
            _value = value;
        }


        public Enum Enum
        {
            get { return _enum; }
            set { _enum = value; }
        }

        public string Value
        {
            get { return _value; }
            set { _value = value; }
        }
    }
}