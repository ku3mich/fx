using System;
using System.Diagnostics;

namespace AnjLab.FX.IO
{
    public enum LogLevel
    {
        DEBUG, INFO, WARNING, ERROR, FATAL
    }

    public class TraceLog : ILog
    {
        public void Info(string message, params object[] args)
        {
            Trace.TraceInformation(message, args);
            InvokeLogMessage(LogLevel.INFO.ToString(), string.Format(message, args));
        }

        public void Debug(string message, params object[] args)
        {
            Info(message, args);
            InvokeLogMessage(LogLevel.DEBUG.ToString(), string.Format(message, args));
        }

        public void Warning(string message, params object[] args)
        {
            Trace.TraceWarning(message, args);
            InvokeLogMessage(LogLevel.WARNING.ToString(), string.Format(message, args));
        }

        public void Error(string message, params object[] args)
        {
            Trace.TraceError(message, args);
            InvokeLogMessage(LogLevel.ERROR.ToString(), string.Format(message, args));
        }

        public void Fatal(string message, params object[] args)
        {
            Trace.TraceError(message, args);
            InvokeLogMessage(LogLevel.FATAL.ToString(), string.Format(message, args));
        }


        public void Info(string message)
        {
            Trace.TraceInformation(message);
            InvokeLogMessage(LogLevel.INFO.ToString(), message);
        }

        public void Warning(string message)
        {
            Trace.TraceWarning(message);
            InvokeLogMessage(LogLevel.WARNING.ToString(), message);
        }

        public void Error(string message)
        {
            Trace.TraceError(message);
            InvokeLogMessage(LogLevel.ERROR.ToString(), message);
        }

        public void Fatal(string message)
        {
            Trace.TraceError(message);
            InvokeLogMessage(LogLevel.FATAL.ToString(), message);
        }

        public void Debug(string message)
        {
            Info(message);
        }

        public bool IsInfoEnabled
        {
            get { return true; }
        }

        public bool IsWarnEnabled
        {
            get { return true; }
        }

        public bool IsErrorEnabled
        {
            get { return true; }
        }

        public bool IsFatalEnabled
        {
            get { return true; }
        }

        public bool IsDebugEnabled
        {
            get { return true; }
        }

        public event EventHandler<Sys.EventArgs<string, string>> LogMessage;

        private void InvokeLogMessage(string logLevel, string logMessage)
        {
            if (LogMessage != null)
            {
                LogMessage(this, Sys.EventArg.New(logLevel, logMessage));
            }
        }

    }
}
