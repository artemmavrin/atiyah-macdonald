\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{solutions}

% Base class
\LoadClass[12pt, oneside, letterpaper]{book}

% Input encoding
\RequirePackage[utf8]{inputenc}

% Fonts
\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}
\RequirePackage{microtype}

% Math packages
\let\openbox\relax
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{mathtools}
\RequirePackage{mathrsfs}
\RequirePackage{thmtools}

% Page Formatting
\pagestyle{headings}
% \allowdisplaybreaks
\flushbottom

% Programming tools
\RequirePackage{etoolbox}

% Colors
\RequirePackage{xcolor}
\colorlet{@linkcolor}{purple}
\colorlet{@citecolor}{purple}

% Hyperlinks
\RequirePackage[hyperfootnotes=false]{hyperref}
\RequirePackage{bookmark}
\hypersetup{
  pdfborder={0 0 0},
  linktoc=all,
  colorlinks=true,
  citecolor=@citecolor,
  linkcolor=@linkcolor,
}
\AtEndPreamble{
  \hypersetup{
    pdfauthor={\@author},
    pdftitle={\@title},
  }
}

% Good practices
\RequirePackage[all, error]{onlyamsmath}
\RequirePackage[l2tabu, orthodox]{nag}

% Framed environments, used by thmtools to make exercise environment	
\RequirePackage{mdframed}	
\mdfsetup{framemethod=TikZ}

% Exercise and solution environments
\newcommand\@exerciselabel[2]{\label{ex:#1.#2}}
\declaretheoremstyle[
    headfont=\bfseries,
    notebraces={(}{)},
    bodyfont=\normalfont,
    headpunct={.},
    postheadhook={%
        \@exerciselabel{\arabic{chapter}}{\arabic{exercise}}%
        \addcontentsline{toc}{subsection}{\arabic{exercise}}%
    },
    spacebelow=\parsep,
    spaceabove=\parsep,
    headformat={\NAME\arabic{exercise}\NOTE},
]{exercisestyle}
\declaretheorem[%
    name={},
    style=exercisestyle,
    parent=chapter,
    refname={Exercise,Exercises},
    Refname={Exercise,Exercises},
    mdframed={	
        backgroundcolor=gray!10,	
        linecolor=black,	
        innertopmargin=6pt,	
        roundcorner=2pt,	
        innerbottommargin=10pt,	
        skipabove=\parsep,	
        skipbelow=\parsep,	
    },
]{exercise}
\newenvironment{solution}[1][Solution]{\begin{proof}[#1]}{\end{proof}}
\newenvironment{altsolution}[1][Alternative Solution]{\begin{proof}[#1]}{\end{proof}}

% Equation and figure numbering
\numberwithin{equation}{exercise}
\numberwithin{figure}{exercise}

% Theorem-like environments
\declaretheorem[parent=exercise, style=plain]{theorem}
\declaretheorem[sibling=theorem, style=plain]{lemma}
\declaretheorem[sibling=theorem, style=plain]{proposition}
\declaretheorem[sibling=theorem, style=plain]{corollary}
\declaretheorem[sibling=theorem, style=plain]{claim}
\declaretheorem[sibling=theorem, style=definition]{definition}
\declaretheorem[sibling=theorem, style=definition]{example}
\declaretheorem[sibling=theorem, style=definition]{counterexample}
\declaretheorem[sibling=theorem, style=definition]{remark}
\declaretheorem[sibling=theorem, style=definition]{observation}
\declaretheorem[sibling=theorem, style=definition]{notation}
\declaretheorem[sibling=theorem, style=definition]{axiom}

% Custom lists (e.g., exercise parts lists)
\RequirePackage{enumitem}

% Redefine enumerate behavior
\setlist[enumerate, 1]{label=(\arabic*)}
\setlist[enumerate, 2]{label=(\alph*)}

% Exercise parts list
\newlist{parts}{enumerate}{2}
\setlist[parts, 1]{label={\roman*)}}

% Use \part instead of \item in parts environments for automatic label generation
\newcommand\@partlabel[3]{\label{ex:#1.#2.#3}}
\renewcommand\part{\item\@partlabel{\arabic{chapter}}{\arabic{exercise}}{\roman{partsi}}}

% Solution for a problem
\newenvironment{partsolution}[1]{\begin{solution}[Solution, {\normalfont\partref{\arabic{chapter}}{\arabic{exercise}}{#1}}]}{\end{solution}}
\newenvironment{altpartsolution}[1]{\begin{altsolution}[Alternative Solution, {\normalfont\partref{\arabic{chapter}}{\arabic{exercise}}{#1}}]}{\end{altsolution}}

% Remove indent after environments
\newcommand*\@NoIndentAfter{%
    \@ifnextchar\par{%
        \def\par{%
            \everypar{\setbox\z@\lastbox\everypar{}}%
            \@restorepar%
        }%
    }{}%
}
\newrobustcmd*{\NoIndentAfterThis}{\@NoIndentAfter\par\par}

\AfterEndEnvironment{theorem}{\NoIndentAfterThis}
\AfterEndEnvironment{lemma}{\NoIndentAfterThis}
\AfterEndEnvironment{proposition}{\NoIndentAfterThis}
\AfterEndEnvironment{corollary}{\NoIndentAfterThis}
\AfterEndEnvironment{claim}{\NoIndentAfterThis}
\AfterEndEnvironment{proof}{\NoIndentAfterThis}
\AfterEndEnvironment{definition}{\NoIndentAfterThis}
\AfterEndEnvironment{example}{\NoIndentAfterThis}
\AfterEndEnvironment{counterexample}{\NoIndentAfterThis}
\AfterEndEnvironment{remark}{\NoIndentAfterThis}
\AfterEndEnvironment{notation}{\NoIndentAfterThis}
\AfterEndEnvironment{axiom}{\NoIndentAfterThis}
\AfterEndEnvironment{enumerate}{\NoIndentAfterThis}
\AfterEndEnvironment{exercise}{\NoIndentAfterThis}
\AfterEndEnvironment{parts}{\NoIndentAfterThis}

% Drawing
\RequirePackage{tikz}
\usetikzlibrary{calc}
\usetikzlibrary{arrows}
\usetikzlibrary{cd}
\tikzcdset{
    diagrams={sep=large},
}

% Captions for, e.g., figures
\RequirePackage[labelfont=bf, margin=\parindent]{caption}

% Comma between consecutive footnotes
\RequirePackage[multiple]{footmisc}

% Bibliography/references
\RequirePackage[backend=biber]{biblatex}

% Generate solutions body
\newcommand\@MAXCHAPTERS{11}
\newcommand\@MAXEXERCISES{40}
\newcommand\@twodigits[1]{%
    \ifnumless{#1}{10}{0#1}{#1}%
}
\newcommand\@chapterdir{}
\newcommand\@exercisefilenoext{}
\newcommand\@chapterlabel[1]{\label{ch:#1}}
\newcommand{\GenerateSolutions}{
    % Loop over chapters
    \foreach \@c in {1,2,...,\@MAXCHAPTERS}{%
        \renewcommand\@chapterdir{./chapters/\@twodigits{\@c}}
        % Each chapter directory should have a main.tex that defines the \chapter
        % for that chapter 
        \IfFileExists{\@chapterdir/main.tex}{
            % Advance chapter counter to force correct numbering
            \setcounter{chapter}{\@c}
            \addtocounter{chapter}{-1}
            % Read chapter heading
            \input{\@chapterdir/main}
            % Add chapter label
            \@chapterlabel{\arabic{chapter}}%
            % Loop over exercises in the chapter
            \foreach \@e in {1,2,...,\@MAXEXERCISES}{%
                \renewcommand\@exercisefilenoext{\@chapterdir/exercises/\@twodigits{\@e}}
                \IfFileExists{{\@exercisefilenoext}.tex}{
                    % Advance exercise environment counter based on name from file name
                    \setcounter{exercise}{\@e}%
                    \addtocounter{exercise}{-1}%
                    % Include exercise + solution
                    \input{\@exercisefilenoext}
                }{}%
            }{}%
        }{}%
    }%
}

% Referencing shortcuts
\newcommand\ifcurrentchapter[1]{\ifnumequal{#1}{\arabic{chapter}}}
\newcommand\chref[1]{\hyperref[ch:#1]{Chapter~#1}}
\newcommand\exref[2]{%
    \ifcurrentchapter{#1}{%
        \hyperref[ex:#1.#2]{Exercise~#2}%
    }{%
        \hyperref[ex:#1.#2]{Chapter~#1, Exercise~#2}%
    }%
}
\newcommand\partref[3]{\ref{ex:#1.#2.#3}}
\newcommand\expartref[3]{%
    \ifcurrentchapter{#1}{%
        \hyperref[ex:#1.#2.#3]{Exercise~#2,~\partref{#1}{#2}{#3}}%
    }{%
        \hyperref[ex:#1.#2.#3]{Chapter~#1, Exercise~#2,~\partref{#1}{#2}{#3}}%
    }%
}

% A more compact table of contents
\RequirePackage{titletoc}
\titlecontents*%
    {section} % section name witnout backslash
    [0em] % left margin
    {\contentsmargin{0em}} % above-code
    {\itshape} % numbered-entry-format
    {\itshape} % numberless-entry-format
    {} % filler-page-format
    [,\space\space] % separator
\titlecontents*%
    {subsection} % section name without backslash
    [0em] % left margin
    {\contentsmargin{0em}} % above-code
    {} % numbered-entry-format
    {} % numberless-entry-format
    {} % filler-page-format
    [,\space\space] % begin
    [,\space\space] % separator
    [] % end

% Change appearance of chapter and section headings
\RequirePackage{titlesec}
\titleformat{\chapter}%
    [display] % shape
    {\normalfont\bfseries\Huge} % format
    {\thechapter} % label
    {20pt} % sep
    {} % before-code
\titleformat{\section}%
    [hang] % shape
    {\normalfont\bfseries\itshape} % format
    {} % label
    {0pt} % sep
    {} % before-code