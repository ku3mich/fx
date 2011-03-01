using AnjLab.FX.Wpf.Dialogs.Interop;
using System;
using System.Runtime.InteropServices;

namespace AnjLab.FX.Wpf.Dialogs
{
    /// <summary>Describes an action being performed.</summary>
	public enum OperationAction : uint
	{
		/// <summary>No action is being performed.</summary>
		None = 0,
		/// <summary>Files are being moved.</summary>
		Moving = (None + 1),
		/// <summary>Files are being copied.</summary>
		Copying = (Moving + 1),
		/// <summary>Files are being deleted.</summary>
		Recycling = (Copying + 1),
		/// <summary>A set of attributes are being applied to files.</summary>
		ApplyingAttributes = (Recycling + 1),
		/// <summary>A file is being downloaded from a remote source.</summary>
		Downloading = (ApplyingAttributes + 1),
		/// <summary>An Internet search is being performed.</summary>
		SearchingInternet = (Downloading + 1),
		/// <summary>A calculation is being performed.</summary>
		Calculating = (SearchingInternet + 1),
		/// <summary>A file is being uploaded to a remote source.</summary>
		Uploading = (Calculating + 1),
		/// <summary>A local search is being performed.</summary>
		SearchingFiles = (Uploading + 1),
		/// <summary>A deletion is being performed.</summary>
		Deleting = (SearchingFiles + 1),
		/// <summary>A renaming action is being performed.</summary>
		Renaming = (Deleting + 1),
		/// <summary>A formatting action is being performed.</summary>
		Formatting = (Renaming + 1)
	}

	/// <summary>Indicates opeartions mode.</summary>
	public enum OperationMode : uint
	{
		None = 0x0,
		/// <summary>Indicates operation is running.</summary>
		Run = 0x1,
		/// <summary>Indicates pre-flight mode, calculating operation time.</summary>
		Preflight = 0x2,
		/// <summary>Indicates operation is rolling back, undo has been selected.</summary>
		Undoing = 0x4,
		/// <summary>Indicates error dialogs are blocking progress from completing.</summary>
		ErrorsBlocking = 0x8,
		/// <summary>Indicates length of the operation is indeterminate.</summary
		/// <remarks>Don't show a timer, progressbar is in marquee mode.</remarks>
		Indeterminate = 0x10
	}

	/// <summary>Provides operation status values.</summary>
	public enum OperationStatus : uint
	{
		/// <summary>Operation is running, no user intervention.</summary>
		Running = 0x1,
		/// <summary>Operation has been paused by the user.</summary>
		Paused = 0x2,
		/// <summary>Operation has been canceled by the user - now go undo.</summary>
		Cancelled = 0x3,
		/// <summary>Operation has been stopped by the user - terminate completely.</summary>
		Stopped = 0x4,
		/// <summary>Operation has gone as far as it can go without throwing error dialogs.</summary>
		Errors = 0x5
	}

	/// <summary>Displays a progress dialog box that shows an action being performed on items.</summary>
	public class OperationsProgressDialog : ProgressDialog
	{
		private readonly IOperationsProgressDialog instance;
		private OperationAction action;
		private OperationMode mode;
		private ulong size;
		private ulong totalSize;
		private ulong count;
		private ulong totalCount;
		private string sourcePath;
		private string targetPath;

		public OperationsProgressDialog()
			: base()
		{
			instance = (IOperationsProgressDialog)coclassObject;
		}

		/// <summary>Gets or sets which progress dialog operation is occuring.</summary>
		public OperationAction Action
		{
			get
			{
				return action;
			}
			set
			{
				action = value;
				if (IsVisible)
					instance.SetOperation(action);
			}
		}

		/// <summary>Gets or sets progress dialog operations mode.</summary>
		public OperationMode Mode
		{
			get
			{
				return mode;
			}
			set
			{
				mode = value;
				if (IsVisible)
					instance.SetMode(mode);
			}
		}

		/// <summary>Gets operation status for progress dialog.</summary>
		public OperationStatus Status
		{
			get
			{
				OperationStatus value;
				instance.GetOperationStatus(out value);
				return value;
			}
		}

		/// <summary>
		/// Gets or sets a value that indicates the operation
		/// can be paused and adds a pause button.
		/// </summary>
		public bool HasPauseButton
		{
			get { return GetOption((uint)PROGDLG.OPPROGDLG_ENABLEPAUSE); }
			set { SetOption((uint)PROGDLG.OPPROGDLG_ENABLEPAUSE, value); }
		}

		/// <summary>
		/// Gets or sets a value that indicates the operation
		/// can be undone in the dialog or not.
		/// </summary>
		public bool AllowsUndo
		{
			get { return GetOption((uint)PROGDLG.OPPROGDLG_ALLOWUNDO); }
			set { SetOption((uint)PROGDLG.OPPROGDLG_ALLOWUNDO, value); }
		}

		/// <summary>
		/// Gets or sets the source shell item path or parsing name
		/// to generate from/to display for the progress dialog.
		/// </summary>
		public string SourcePath
		{
			get
			{
				return sourcePath;
			}
			set
			{
				sourcePath = value;
				UpdateLocations();
			}
		}

		/// <summary>
		/// Gets or sets the target shell item path or parsing name
		/// to generate from/to display for the progress dialog.
		/// </summary>
		public string TargetPath
		{
			get
			{
				return targetPath;
			}
			set
			{
				targetPath = value;
				UpdateLocations();
			}
		}

		/// <summary>
		/// Gets or sets a value that indicates whether the path
		/// of source item should be displayed in the progress dialog.
		/// </summary>
		public bool DisplaysSourcePath
		{
			get { return !GetOption((uint)PROGDLG.OPPROGDLG_DONTDISPLAYSOURCEPATH); }
			set { SetOption((uint)PROGDLG.OPPROGDLG_DONTDISPLAYSOURCEPATH, !value); }
		}

		/// <summary>
		/// Gets or sets a value that indicates whether the path
		/// of target item should be displayed in the progress dialog.
		/// </summary>
		public bool DisplaysTargetPath
		{
			get { return !GetOption((uint)PROGDLG.OPPROGDLG_DONTDISPLAYDESTPATH); }
			set { SetOption((uint)PROGDLG.OPPROGDLG_DONTDISPLAYDESTPATH, !value); }
		}

		public override bool EstimatesTimeRemaining
		{
			get
			{
				return true;
			}
			set
			{
			}
		}

		public override bool ProgressBarIsMarquee
		{
			get
			{
				return Mode == OperationMode.Indeterminate;
			}
			set
			{
				Mode = value ? OperationMode.Indeterminate : OperationMode.Run;
			}
		}

		public override bool IsCancelled
		{
			get { return Status == OperationStatus.Cancelled; }
		}

		/// <summary>Gets or sets the current size in bytes, used for showing progress in bytes.</summary>
		public ulong Size
		{
			get
			{
				return size;
			}
			set
			{
				size = value;
				UpdateProgress();
			}
		}

		/// <summary>Gets or sets the total size in bytes, used for showing progress in bytes.</summary>
		public ulong TotalSize
		{
			get
			{
				return totalSize;
			}
			set
			{
				totalSize = value;
				UpdateProgress();
			}
		}

		/// <summary>Gets or sets the number of current items, used for showing progress in items.</summary>
		public ulong Count
		{
			get
			{
				return count;
			}
			set
			{
				count = value;
				UpdateProgress();
			}
		}

		/// <summary>Gets or sets the total number of items, used for showing progress in items.</summary>
		public ulong TotalCount
		{
			get
			{
				return totalCount;
			}
			set
			{
				totalCount = value;
				UpdateProgress();
			}
		}

		public override void Reset()
		{
			base.Reset();
			action = OperationAction.None;
			mode = OperationMode.None;
			size = 0ul;
			totalSize = 0ul;
			count = 0ul;
			totalCount = 0ul;
		}

		protected override void RunDialogImpl(IntPtr hwndOwner)
		{
			instance.StartProgressDialog(hwndOwner, (PROGDLG)Options);
			if (action != OperationAction.None)
				instance.SetOperation(action);
			if (mode != OperationMode.None)
				instance.SetMode(mode);
			UpdateLocations();
			UpdateProgress();
		}

		protected override void UpdateProgress()
		{
			if (IsVisible)
				instance.UpdateProgress(Value, TotalValue, Size, TotalSize, Count, TotalCount);
		}

		private void UpdateLocations()
		{
			if (!IsVisible)
				return;

			var sourceItem = IntPtr.Zero;
			var targetItem = IntPtr.Zero;
			try {
				var interfaceId = new Guid(IID_IShellItem);

				SHCreateItemFromParsingName(sourcePath, IntPtr.Zero, ref interfaceId, out sourceItem);
				SHCreateItemFromParsingName(targetPath, IntPtr.Zero, ref interfaceId, out targetItem);

				instance.UpdateLocations(sourceItem, targetItem, IntPtr.Zero);
			}
			finally {
				if (sourceItem != IntPtr.Zero)
					Marshal.Release(sourceItem);
				if (targetItem != IntPtr.Zero)
					Marshal.Release(targetItem);
			}
		}

		private const string IID_IShellItem = "43826D1E-E718-42EE-BC55-A1E261C37BFE";

		[DllImport("shell32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
		private static extern uint SHCreateItemFromParsingName(
				[MarshalAs(UnmanagedType.LPWStr)] string path,
				IntPtr pbc,
				ref Guid riid,
				out IntPtr shellItem);
	}
}
