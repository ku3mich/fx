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
            var result = new List<KeyValuePair<object, string>>();
            Type dataType = source.GetType();
            foreach (var value in Enum.GetValues(dataType))
            {
                FieldInfo fieldInfo = value.GetType().GetField(value.ToString());

                var attrs = fieldInfo.GetCustomAttributes(typeof(EnumValueAttribute), false) as EnumValueAttribute[];
                if (attrs != null && attrs.Length > 0)
                    result.Add(new KeyValuePair<object, string>(value, attrs.First().Description));
                else
                    result.Add(new KeyValuePair<object, string>(value, value.ToString()));
            }
            return result;
        }

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
