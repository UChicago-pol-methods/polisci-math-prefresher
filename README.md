# University of Chicago Political Science Math Prefresher

## Introduction

The 2023 UChicago Math Prefresher for incoming Political Science graduate students will be held from September 12-15 and September 18-20. The course is designed as a brief review of math fundamentals -- calculus, optimization, probability theory and linear algebra among other topics -- as well as an introduction to programming in the R statistical computing language. The course is entirely optional and there are no grades or assignments but we encourage all incoming graduate students to attend if they are able.

## Course Booklet

The course notes for the math and programming sections as well as all practice problems are made available on this website and can be accessed by navigating the menus in the sidebar.

## Schedule

The prefresher will run for a total of seven days September 12-15, and September 18-20 in *Pick Hall 506*. Each day will run from around 9am to 4pm with many breaks in between.

The morning will focus on math instruction. We will have two one hour sessions from 9:30am - 10:30am and 10:45am-11:45am, with a ~15 minute break in between. These sessions will involve a combination of lectures and working through practice problems. 

We will break for lunch from 12:00pm-1:00pm.

The afternoon will focus on coding instruction with lecture/demonstration from 1:00pm-2:45pm.  After a short break you will work together on a variety of coding exercises from 3:00-3:30pm. In the last 30 minutes we will regroup to wrap up and discuss any questions on the material.

## Software

As the afternoons of the prefresher will involve instruction in coding, you should be sure to bring a laptop and a charge cable. In addition, prior to the start of the prefresher, please make sure to have installed the following on your computer.

- [R](https://www.r-project.org/) (version 4.2.1 or higher)
- [RStudio Desktop Open Source License](https://www.rstudio.com/products/rstudio/) (this is the primary IDE or integrated development environment in which we will be working)
- LaTeX: This is primarily to allow you to generate PDF documents using RMarkdown. We will use the TinyTeX LaTeX distribution which is designed to be minimalist and tailored specifically for R users. After installing R and RStudio, open up an instance of R, install the 'tinytex' package and run the `install_tinytex()` command 

```{r, eval=FALSE}
install.packages('tinytex')
tinytex::install_tinytex()
```

We will also spend some time discussing document preparation and typesetting using LaTeX and Markdown. For the former, we will be using the popular cloud platform [Overleaf](https://www.overleaf.com/), which allows for collaborative document editing and streamlines a lot of the irritating parts of typesetting in LaTeX. You should register for an account using your university e-mail as all University of Chicago students and faculty [have access](https://guides.lib.uchicago.edu/latex) to an Overleaf Pro account for free.

You are also welcome to install a LaTeX editor on your local machine to work alongside the TinyTeX distribution or any other TeX distribution that you prefer such as [TexMaker](https://www.xm1math.net/texmaker/)

## Acknowledgments

This prefresher draws heavily on the wonderful materials that have been developed by over 20 years of instructors at the [Harvard Government Math Prefresher](https://github.com/IQSS/prefresher) that have been so generously distributed under the GPL 3.0 License. Special thanks to Shiro Kuriwaki, Yon Soo Park, and Connor Jerzak for their efforts in converting the original prefresher materials into the easily distributed Markdown format.
