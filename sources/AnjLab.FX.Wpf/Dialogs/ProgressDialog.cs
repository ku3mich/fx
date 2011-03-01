using AnjLab.FX.Wpf.Dialogs.Interop;
using System;
using Microsoft.Win32;

namespace AnjLab.FX.Wpf.Dialogs
{
    /// <summary>Displays a progress dialog box.</summary>
	public class ProgressDialog : CommonDialog
	{
		private const uint CaptionLineIndex = 1u;
		private const uint MessageLineIndex = 2u;
		private const uint TimeRemainingLineIndex = 3u;

		protected readonly object coclassObject;
		private readonly IProgressDialog instance;
		private PROGDLG options;
		private ulong totalValue;
		private ulong value;
		private string title;
		private string caption;
		private string message;
		private string timeRemaining;
		private string cancelMessage;

		public ProgressDialog()
			: base()
		{
			coclassObject = new Interop.ProgressDialog();
			instance = (IProgressDialog)coclassObject;
			Reset();
		}

		/// <summary>Gets a value indicating whether the progress dialog box is visible on the screen.</summary>
		public bool IsVisible { get; private set; }

		/// <summary>Gets or sets the title of the progress dialog box.</summary>
		public string Title
		{
			get
			{
				return title;
			}
			set
			{
				title = value;
				instance.SetTitle(title);
			}
		}

		/// <summary>Gets or sets the caption of the progress dialog box.</summary>
		public string Caption
		{
			get
			{
				return caption;
			}
			set
			{
				caption = value;
				instance.SetLine(CaptionLineIndex, caption, CompactsPaths, IntPtr.Zero);
			}
		}

		/// <summary>Gets or sets a message to be displayed during the operation.</summary>
		public string Message
		{
			get
			{
				return message;
			}
			set
			{
				message = value;
				instance.SetLine(MessageLineIndex, message, CompactsPaths, IntPtr.Zero);
			}
		}

		/// <summary>Displays a message or the estimated time remaining.</summary>
		/// <remarks>The estimated time is displayed if <see cref="EstimatesTimeRemaining"/> is set to <c>true</c>.</remarks>
		public string TimeRemaining
		{
			get
			{
				return timeRemaining;
			}
			set
			{
				timeRemaining = value;
				instance.SetLine(TimeRemainingLineIndex, timeRemaining, CompactsPaths, IntPtr.Zero);
			}
		}

		/// <summary>Gets or sets a message to be displayed if the user cancels the operation.</summary>
		public string CancelMessage
		{
			get
			{
				return cancelMessage;
			}
			set
			{
				cancelMessage = value;
				instance.SetCancelMsg(cancelMessage, IntPtr.Zero);
			}
		}

		/// <summary>
		/// Gets or sets a value that indicates whether path strings
		/// are compacted if they are too large to fit on a line.
		/// </summary>
		public bool CompactsPaths { get; set; }

		/// <summary>Gets or sets the current progress of the operation in points.</summary>
		public ulong Value
		{
			get
			{
				return value;
			}
			set
			{
				this.value = value;
				UpdateProgress();
			}
		}

		/// <summary>Gets or sets the highest possible <see cref="Value"/> of the operation state.</summary>
		public ulong TotalValue
		{
			get
			{
				return totalValue;
			}
			set
			{
				totalValue = value;
				UpdateProgress();
			}
		}

		/// <summary>Gets or sets a value that specifies whether the progress dialog box is modal.</summary>
		public bool IsModal
		{
			get { return GetOption((uint)PROGDLG.PROGDLG_MODAL); }
			set { SetOption((uint)PROGDLG.PROGDLG_MODAL, value); }
		}

		/// <summary>Gets or sets a value that indicates whether the dialog box can be minimized.</summary>
		public bool HasMinimizeButton
		{
			get { return !GetOption((uint)PROGDLG.PROGDLG_NOMINIMIZE); }
			set { SetOption((uint)PROGDLG.PROGDLG_NOMINIMIZE, !value); }
		}

		/// <summary>Gets or sets a value that indicates whether the "time remaining" text is shown.</summary>
		public bool ShowsTimeRemaining
		{
			get { return !GetOption((uint)PROGDLG.PROGDLG_NOTIME); }
			set { SetOption((uint)PROGDLG.PROGDLG_NOTIME, !value); }
		}

		/// <summary>Gets or sets a value that indicates whether the time remaining is estimated.</summary>
		public virtual bool EstimatesTimeRemaining
		{
			get { return GetOption((uint)PROGDLG.PROGDLG_AUTOTIME); }
			set { SetOption((uint)PROGDLG.PROGDLG_AUTOTIME, value); }
		}

		/// <summary>Gets or sets a value that indicates whether the progress dialog box has a progress bar.</summary>
		public bool HasProgressBar
		{
			get { return !GetOption((uint)PROGDLG.PROGDLG_NOPROGRESSBAR); }
			set { SetOption((uint)PROGDLG.PROGDLG_NOPROGRESSBAR, !value); }
		}

		/// <summary>Gets or sets a value that indicates whether the progress bar is displayed as marquee.</summary>
		public virtual bool ProgressBarIsMarquee
		{
			get { return GetOption((uint)PROGDLG.PROGDLG_MARQUEEPROGRESS); }
			set { SetOption((uint)PROGDLG.PROGDLG_MARQUEEPROGRESS, value); }
		}

		/// <summary>Gets or sets a value that indicates whether the user can cancel the operation.</summary>
		public bool HasCancelButton
		{
			get { return !GetOption((uint)PROGDLG.PROGDLG_NOCANCEL); }
			set { SetOption((uint)PROGDLG.PROGDLG_NOCANCEL, !value); }
		}

		/// <summary>Checks whether the user has canceled the operation.</summary>
		public virtual bool IsCancelled
		{
			get { return instance.HasUserCancelled(); }
		}

		protected uint Options
		{
			get { return (uint)options; }
		}

		/// <summary>Resets the properties of the progress dialog to their default values.</summary>
		public override void Reset()
		{
			options = PROGDLG.PROGDLG_NORMAL;
			totalValue = 0ul;
			value = 0ul;
			CompactsPaths = false;
			Title = String.Empty;
			Caption = String.Empty;
			Message = String.Empty;
			TimeRemaining = String.Empty;
			CancelMessage = String.Empty;
		}

		/// <summary>Closes the progress dialog box.</summary>
		public void CloseDialog()
		{
			if (IsVisible) {
				instance.StopProgressDialog();
				IsVisible = false;
			}
		}

		protected override bool RunDialog(IntPtr hwndOwner)
		{
			if (IsVisible)
				throw new InvalidOperationException();

			IsVisible = true;
			RunDialogImpl(hwndOwner);
			return IsVisible;
		}

		protected virtual void RunDialogImpl(IntPtr hwndOwner)
		{
			instance.StartProgressDialog(hwndOwner, null, options, IntPtr.Zero);
			UpdateProgress();
		}

		protected bool GetOption(uint option)
		{
			return (options & (PROGDLG)option) != PROGDLG.PROGDLG_NORMAL;
		}

		protected void SetOption(uint option, bool value)
		{
			if (value)
				options |= (PROGDLG)option;
			else
				options &= ~((PROGDLG)option);
		}

		protected virtual void UpdateProgress()
		{
			if (IsVisible)
				instance.SetProgress64(Value, TotalValue);
		}
	}
}
