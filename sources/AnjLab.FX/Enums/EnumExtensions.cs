using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace AnjLab.FX.Enums
{
    public static class EnumExtensions
    {
        private static readonly Dictionary<Type, Dictionary<object, string>> enumDescriptions = new Dictionary<Type, Dictionary<object, string>>();

        public static IList<KeyValuePair<object, string>> GetDescriptions(this Enum source)
        {
            return GetEnumDescriptions(source.GetType());
        }

        private class EnumOrderedValue
        {
            public KeyValuePair<object, string> Value { get; private set; }

            public int Position { get; private set; }

            public EnumOrderedValue(object obj, string value)
            {
                Value = new KeyValuePair<object, string>(obj, value);
                Position = int.MaxValue;
            }

            public EnumOrderedValue(object obj, string value, int pos)
                : this (obj, value)
            {
                Position = pos;
            }
        }

        public static IList<KeyValuePair<object, string>> GetEnumDescriptions(this Type enumType)
        {
            var result = new List<EnumOrderedValue>();
            foreach (var value in Enum.GetValues(enumType))
            {
                FieldInfo fieldInfo = value.GetType().GetField(value.ToString());

                var attrs = fieldInfo.GetCustomAttributes(typeof(EnumValueAttribute), false) as EnumValueAttribute[];
                if (attrs != null && attrs.Length > 0)
                    result.Add(new EnumOrderedValue(value, attrs.First().Description, attrs.First().Position));
                else
                    result.Add(new EnumOrderedValue(value, value.ToString()));
            }
            return result.OrderBy(i => i.Position).Select(i => i.Value).ToList();
        }

        //public static IList<KeyValuePair<object, string>> GetEnumDescriptions(this Type enumType)
        //{
        //    var result = new List<KeyValuePair<object, string>>();
        //    foreach (var value in Enum.GetValues(enumType))
        //    {
        //        FieldInfo fieldInfo = value.GetType().GetField(value.ToString());

        //        var attrs = fieldInfo.GetCustomAttributes(typeof(EnumValueAttribute), false) as EnumValueAttribute[];
        //        if (attrs != null && attrs.Length > 0)
        //            result.Add(new KeyValuePair<object, string>(value, attrs.First().Description));
        //        else
        //            result.Add(new KeyValuePair<object, string>(value, value.ToString()));
        //    }
        //    return result;
        //}

        public static string ToValueString(this Enum enumValue)
        {
            var type = enumValue.GetType();
            if (!enumDescriptions.ContainsKey(type))
                enumDescriptions.Add(type, enumValue.ToDictionary<object>());
            return enumDescriptions[type][enumValue];
        }

        public static Dictionary<T, string> ToDictionary<T>(this Enum source)
        {
            return source.GetDescriptions().ToDictionary(keyValue => (T)keyValue.Key, keyValue => keyValue.Value);
        }
    }
}
