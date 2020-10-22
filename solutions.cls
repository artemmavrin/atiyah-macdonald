\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{solutions}

% Base class
\LoadClass[12pt, letterpaper]{article}

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

% Index (load before hyperref)
\RequirePackage{imakeidx}
\makeindex[columns=2, intoc]

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
    headpunct={},
    postheadspace={\newline},
    postheadhook={%
        \textcolor{gray!80}{\rule[.6ex]{\linewidth}{0.4pt}}{\\}%
        \@exerciselabel{\arabic{section}}{\arabic{exercise}}%
        \addcontentsline{toc}{subsection}{Exercise \arabic{section}.\arabic{exercise}}%
    },
    spacebelow=\parsep,
    spaceabove=\parsep,
    mdframed={
        backgroundcolor=gray!10,
        linecolor=black,
        innertopmargin=6pt,
        roundcorner=2pt,
        innerbottommargin=6pt,
        skipabove=\parsep,
        skipbelow=\parsep,
    },
]{exercisestyle}
\declaretheorem[style=exercisestyle, name=Exercise, numberwithin=section]{exercise}
\newenvironment{solution}[1][Solution]{\begin{proof}[#1]}{\end{proof}}

% Shortcut: reference an exercise
\newcommand\exref[2]{Exercise~\ref{ex:#1.#2}}

% Equation and figure numbering
\numberwithin{equation}{exercise}
\numberwithin{figure}{exercise}

% Theorem-like environments
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[exercise]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{claim}[theorem]{Claim}

\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem{counterexample}[theorem]{Counterexample}
\newtheorem{remark}[theorem]{Remark}
\newtheorem{observation}[theorem]{Observation}
\newtheorem{notation}[theorem]{Notation}
\newtheorem{axiom}[theorem]{Axiom}

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
\renewcommand\part{\item\@partlabel{\arabic{section}}{\arabic{exercise}}{\roman{partsi}}}

% Shortcut: reference an exercise part
\newcommand\partref[3]{\ref{ex:#1.#2.#3}}
\newcommand\expartref[3]{\exref{#1}{#2}~\ref{ex:#1.#2.#3}}

% Solution for a problem
\newenvironment{partsolution}[3]{\begin{solution}[Solution, {\normalfont\partref{#1}{#2}{#3}}]}{\end{solution}}

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

% Use \frontmatter, \mainmatter, and \backmatter in article document classes
\newcommand\frontmatter{%
    \cleardoublepage
    \pagenumbering{roman}
}
\newcommand\mainmatter{
    \cleardoublepage
    \pagenumbering{arabic}
}
\newcommand\backmatter{\cleardoublepage}

% Prettier arrows
\renewcommand{\to}{\mathchoice{\longrightarrow}{\rightarrow}{\rightarrow}{\rightarrow}}
\newcommand{\To}{\mathchoice{\Longrightarrow}{\Rightarrow}{\Rightarrow}{\Rightarrow}}
\let\mapstoo\mapsto
\renewcommand{\mapsto}{\mathchoice{\longmapsto}{\mapstoo}{\mapstoo}{\mapstoo}}

% Generate solutions body
\newcommand\@MAXCHAPTERS{11}
\newcommand\@MAXEXERCISES{40}
\newcommand\@twodigits[1]{%
    \ifnumless{#1}{10}{0#1}{#1}%
}
\newcommand\@chapterdir{}
\newcommand\@exercisefilenoext{}
\newcommand{\GenerateSolutions}{
    % Loop over chapters
    \foreach \@c in {1,2,...,\@MAXCHAPTERS}{%
        \renewcommand\@chapterdir{./chapters/\@twodigits{\@c}}
        % Each chapter directory should have a main.tex that defines the \section
        % for that chapter 
        \IfFileExists{\@chapterdir/main.tex}{
            % Advance section counter to force correct numbering
            \setcounter{section}{\@c}
            \addtocounter{section}{-1}
            % Read chapter heading
            \input{\@chapterdir/main}
            % Loop over exercises in the chapter
            \foreach \@e in {1,2,...,\@MAXEXERCISES}{%
                \renewcommand\@exercisefilenoext{\@chapterdir/exercises/\@twodigits{\@e}}
                \IfFileExists{{\@exercisefilenoext}.tex}{
                    % Advance exercise environment counter based on name from file name
                    \count@\c@exercise%
                    \global\c@exercise\@e%
                    \global\advance\c@exercise\m@ne%
                    % Include exercise + solution
                    \input{\@exercisefilenoext}
                }{}%
            }{}%
        }{}%
    }%
}

% Allow starred definitions of macros
% https://tex.stackexchange.com/a/4388/23505
\RequirePackage{suffix}

% Change \subsection behavior (no number, and put it in the TOC automatically)
\let\@oldsubsection\subsection
\renewcommand\subsection[1]{%
    \@oldsubsection*{#1}%
    \addcontentsline{toc}{subsection}{#1}%
}