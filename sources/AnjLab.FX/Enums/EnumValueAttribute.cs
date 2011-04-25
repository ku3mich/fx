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

        public EnumValueAttribute(string description, int position)
            : this (description)
        {
            Position = position;
        }

        public string Description { get; set; }

        public int Position { get; set; }
    }
}
