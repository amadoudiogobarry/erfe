## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Resubmission

This is a resubmission. In this version I have:

* I removed commented lines in my example in sim_panel_data.Rd

For a CRAN submission we recommend that you fix all NOTEs, WARNINGs and ERRORs.
## Test environments
- R-hub windows-x86_64-devel (r-devel)
- R-hub ubuntu-gcc-release (r-release)
- R-hub fedora-clang-devel (r-devel)

## R CMD check results
❯ On ubuntu-gcc-release (r-release)
  checking CRAN incoming feasibility ... NOTE
  Maintainer: ‘Amadou Barry <barryhafia@gmail.com>’
  
  New submission
  
  Possibly Les notes  words in DESCRIPTION:
    Charpentier (16:5)
    ERFE (9:62, 10:20, 12:31, 13:58, 17:5)
    expectile (11:58)
    Expectile (3:13, 9:23)
    expectiles (13:12)
    Oualkacha (15:50)

❯ On fedora-clang-devel (r-devel)
  checking CRAN incoming feasibility ... [6s/28s] NOTE
  Maintainer: ‘Amadou Barry <barryhafia@gmail.com>’
  
  New submission
  
  Possibly misspelled words in DESCRIPTION:
    Charpentier (16:5)
    ERFE (9:62, 10:20, 12:31, 13:58, 17:5)
    Expectile (3:13, 9:23)
    Oualkacha (15:50)
    expectile (11:58)
    expectiles (13:12)

❯ On fedora-clang-devel (r-devel)
  checking HTML version of manual ... NOTE
  Skipping checking HTML validation: no command 'tidy' found
  Skipping checking math rendering: package 'V8' unavailable

0 errors ✔ | 0 warnings ✔ | 3 notes ✖

The notes indicate misspelled words, but the spelling is correct. 
We have added a reference in the Description file to clarify.

