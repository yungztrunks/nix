{ ... }:

{
	programs.lazygit = {
		enable = true;

		settings = {
			gui = {
				nerdFontsVersion = "3";
				sidePanelWidth = 0.3;
				expandFocusedSidePanel = true;
				expandedSidePanelWeight = 2;
				mainPanelSplitMode = "flexible";
				splitDiff = "auto";
				wrapLinesInStagingView = true;
				useHunkModeInStagingView = true;
				scrollHeight = 2;
				scrollOffMargin = 4;
				scrollOffBehavior = "margin";
				showFileTree = true;
				showRootItemInFileTree = true;
				fileTreeSortOrder = "foldersFirst";
				showNumstatInFilesView = true;
				showBranchCommitHash = true;
				showDivergenceFromBaseBranch = "arrowAndNumber";
				commandLogSize = 10;
				showCommandLog = true;
				showBottomLine = true;
				showPanelJumps = true;
				showRandomTip = false;
				border = "rounded";
				statusPanelView = "dashboard";

				theme = {
					activeBorderColor = [ "green" "bold" ];
					inactiveBorderColor = [ "default" ];
					searchingActiveBorderColor = [ "cyan" "bold" ];
					optionsTextColor = [ "blue" ];
					selectedLineBgColor = [ "reverse" ];
					inactiveViewSelectedLineBgColor = [ "bold" ];
					unstagedChangesColor = [ "red" ];
					defaultFgColor = [ "default" ];
				};
			};

			git = {
				autoFetch = true;
				autoRefresh = true;
				fetchAll = true;
				autoForwardBranches = "onlyMainBranches";
				autoStageResolvedConflicts = true;
				disableForcePushing = true;
				mainBranches = [ "main" "master" "develop" ];
				localBranchSortOrder = "recency";
				remoteBranchSortOrder = "alphabetical";
				truncateCopiedCommitHashesTo = 12;
				parseEmoji = true;

				commit = {
					autoWrapCommitMessage = true;
					autoWrapWidth = 72;
					signOff = false;
				};

				log = {
					order = "topo-order";
					showGraph = "always";
					showWholeGraph = false;
				};

				branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium {{branchName}} --";
				allBranchesLogCmds = [
					"git log --graph --all --color=always --abbrev-commit --decorate --date=relative --pretty=medium"
				];
			};

			os = {
				editPreset = "nvim";
				open = "xdg-open {{filename}} >/dev/null 2>&1";
				openLink = "xdg-open {{link}} >/dev/null 2>&1";
			};

			update = {
				method = "background";
				days = 14;
			};

			refresher = {
				refreshInterval = 10;
				fetchInterval = 60;
			};

			confirmOnQuit = false;
			quitOnTopLevelReturn = false;
			disableStartupPopups = true;
			promptToReturnFromSubprocess = true;
			notARepository = "prompt";
		};
	};
}
