#!/bin/csh
#
###########################################################################
#  Pre-processor to generate system-dependent source programs, makefile, shell
#  for FreeBSD/f2c+gcc (by Keisuke OKUMURA)
#
#  Note : If this shell is not executed by @PunchMe, set the full path name
#         of the SRAC code file in the following statement, and remove the 
#         first comment indicator(#).                                      
#                                                                          
#  setenv SRAC_CODE $HOME/SRAC
#
###########################################################################
   set SRAC_DIR = $SRAC_CODE
#------------------------- for PC with FreeBSD-----------------------------
   set SYSTM = pc-unix
   set F77   = f77
#  set OPT   = "-Nq300 -Nn802"
# -Nq300 : if too many equivalence
# -Nn802 : if too many names
#--------------------------------------------------------------------------
#
alias cp    cp
alias cd    cd
alias echo  echo
#
#========== System-dependent Source Programs ==============================
#
echo " XXX Installation of system-dependent source programs started."
cd $SRAC_DIR/src/extnl
cp $SYSTM/*.f .
cp $SYSTM/*.c .
echo " XXX Installation of system-dependent source programs completed."
#
#========== System-dependent Makefile =====================================
#
echo " XXX Installation of system-dependent Makefile started."
cd $SRAC_DIR/tool/else/F77conv
set MKOPT = " "
sed -e "s/tmp1/$F77/g" < f77mk.org | sed -e "s/tmp2/$MKOPT/g" >! f77conv.sed
change.sh
echo " XXX Installation of system-dependent Makefile completed."
#
#========== System-dependent Shell-script =================================
#
echo " XXX Installation of system-dependent shell-script started."
cd $SRAC_DIR/tool
cp -r install/SysDpnd/freebsd-f2c/lmmake .
echo " XXX Installation of system-dependent shell-script completed."
#
#==========================================================================
#
echo " XXX All processes of pre-processor completed."
#
#==========================================================================
