using System;

namespace AnjLab.FX.Enums
{
    [AttributeUsage(AttributeTargets.Field)]
    public class EnumValueAttribute : Attribute
    {
        public EnumValueAttribute(string description)
        {
            Description = description;
        }

        public string Description { get; set; }
    }
}
