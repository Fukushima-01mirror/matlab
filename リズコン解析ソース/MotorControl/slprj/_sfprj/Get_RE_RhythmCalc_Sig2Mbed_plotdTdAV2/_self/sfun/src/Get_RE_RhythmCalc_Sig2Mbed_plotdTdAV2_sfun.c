/* Include files */

#include "Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_sfun.h"
#include "Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_sfun_debug_macros.h"
#include "c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2.h"
#include "c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2.h"
#include "c4_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2.h"
#include "c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
uint32_T _Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2MachineNumber_;
real_T _sfTime_;

/* Function Declarations */

/* Function Definitions */
void Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_initializer(void)
{
}

void Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_terminator(void)
{
}

/* SFunction Glue Code */
unsigned int sf_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_method_dispatcher
  (SimStruct *simstructPtr, unsigned int chartFileNumber, const char* specsCksum,
   int_T method, void *data)
{
  if (chartFileNumber==1) {
    c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_method_dispatcher(simstructPtr,
      method, data);
    return 1;
  }

  if (chartFileNumber==2) {
    c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_method_dispatcher(simstructPtr,
      method, data);
    return 1;
  }

  if (chartFileNumber==4) {
    c4_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_method_dispatcher(simstructPtr,
      method, data);
    return 1;
  }

  if (chartFileNumber==5) {
    c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_method_dispatcher(simstructPtr,
      method, data);
    return 1;
  }

  return 0;
}

unsigned int sf_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_process_check_sum_call
  ( int nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[20];
  if (nrhs<1 || !mxIsChar(prhs[0]) )
    return 0;

  /* Possible call to get the checksum */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"sf_get_check_sum"))
    return 0;
  plhs[0] = mxCreateDoubleMatrix( 1,4,mxREAL);
  if (nrhs>1 && mxIsChar(prhs[1])) {
    mxGetString(prhs[1], commandName,sizeof(commandName)/sizeof(char));
    commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
    if (!strcmp(commandName,"machine")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2120088984U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(2837918812U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(294924292U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1068774048U);
    } else if (!strcmp(commandName,"exportedFcn")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(0U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(0U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(0U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(0U);
    } else if (!strcmp(commandName,"makefile")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3072379286U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(488860775U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3744738198U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(10641132U);
    } else if (nrhs==3 && !strcmp(commandName,"chart")) {
      unsigned int chartFileNumber;
      chartFileNumber = (unsigned int)mxGetScalar(prhs[2]);
      switch (chartFileNumber) {
       case 1:
        {
          extern void sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum
            (mxArray *plhs[]);
          sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum(plhs);
          break;
        }

       case 2:
        {
          extern void sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum
            (mxArray *plhs[]);
          sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum(plhs);
          break;
        }

       case 4:
        {
          extern void sf_c4_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum
            (mxArray *plhs[]);
          sf_c4_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum(plhs);
          break;
        }

       case 5:
        {
          extern void sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum
            (mxArray *plhs[]);
          sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum(plhs);
          break;
        }

       default:
        ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(0.0);
        ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(0.0);
      }
    } else if (!strcmp(commandName,"target")) {
      ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2230951352U);
      ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3033329348U);
      ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1649596025U);
      ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(2001809931U);
    } else {
      return 0;
    }
  } else {
    ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2770600877U);
    ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3868840705U);
    ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(600870733U);
    ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(2749319762U);
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int sf_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_autoinheritance_info( int
  nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[32];
  char aiChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]) )
    return 0;

  /* Possible call to get the autoinheritance_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_autoinheritance_info"))
    return 0;
  mxGetString(prhs[2], aiChksum,sizeof(aiChksum)/sizeof(char));
  aiChksum[(sizeof(aiChksum)/sizeof(char)-1)] = '\0';

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 1:
      {
        if (strcmp(aiChksum, "qCoeYgA6mytBQxCLrXHW3D") == 0) {
          extern mxArray
            *sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_autoinheritance_info
            (void);
          plhs[0] =
            sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_autoinheritance_info
            ();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     case 2:
      {
        if (strcmp(aiChksum, "Xrz2a5oPmZD2didNXDb9UD") == 0) {
          extern mxArray
            *sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_autoinheritance_info
            (void);
          plhs[0] =
            sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_autoinheritance_info
            ();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     case 4:
      {
        if (strcmp(aiChksum, "bEydbr1p98IKb9GRmDfEgD") == 0) {
          extern mxArray
            *sf_c4_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_autoinheritance_info
            (void);
          plhs[0] =
            sf_c4_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_autoinheritance_info
            ();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     case 5:
      {
        if (strcmp(aiChksum, "h2XjLU4SWHkzQEotZl66aD") == 0) {
          extern mxArray
            *sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_autoinheritance_info
            (void);
          plhs[0] =
            sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_autoinheritance_info
            ();
          break;
        }

        plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
        break;
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int
  sf_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_eml_resolved_functions_info( int
  nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{

#ifdef MATLAB_MEX_FILE

  char commandName[64];
  if (nrhs<2 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the get_eml_resolved_functions_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_eml_resolved_functions_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 1:
      {
        extern const mxArray
          *sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_eml_resolved_functions_info
          (void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_eml_resolved_functions_info
          ();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     case 2:
      {
        extern const mxArray
          *sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_eml_resolved_functions_info
          (void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_eml_resolved_functions_info
          ();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     case 4:
      {
        extern const mxArray
          *sf_c4_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_eml_resolved_functions_info
          (void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c4_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_eml_resolved_functions_info
          ();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     case 5:
      {
        extern const mxArray
          *sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_eml_resolved_functions_info
          (void);
        mxArray *persistentMxArray = (mxArray *)
          sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_eml_resolved_functions_info
          ();
        plhs[0] = mxDuplicateArray(persistentMxArray);
        mxDestroyArray(persistentMxArray);
        break;
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;

#else

  return 0;

#endif

}

unsigned int sf_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_third_party_uses_info( int
  nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[] )
{
  char commandName[64];
  char tpChksum[64];
  if (nrhs<3 || !mxIsChar(prhs[0]))
    return 0;

  /* Possible call to get the third_party_uses_info */
  mxGetString(prhs[0], commandName,sizeof(commandName)/sizeof(char));
  commandName[(sizeof(commandName)/sizeof(char)-1)] = '\0';
  mxGetString(prhs[2], tpChksum,sizeof(tpChksum)/sizeof(char));
  tpChksum[(sizeof(tpChksum)/sizeof(char)-1)] = '\0';
  if (strcmp(commandName,"get_third_party_uses_info"))
    return 0;

  {
    unsigned int chartFileNumber;
    chartFileNumber = (unsigned int)mxGetScalar(prhs[1]);
    switch (chartFileNumber) {
     case 1:
      {
        if (strcmp(tpChksum, "ZbfLrTY9gmeRypkw93DGGD") == 0) {
          extern mxArray
            *sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_third_party_uses_info
            (void);
          plhs[0] =
            sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_third_party_uses_info();
          break;
        }
      }

     case 2:
      {
        if (strcmp(tpChksum, "m5cExFghLIigpHDoRJNJCD") == 0) {
          extern mxArray
            *sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_third_party_uses_info
            (void);
          plhs[0] =
            sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_third_party_uses_info();
          break;
        }
      }

     case 4:
      {
        if (strcmp(tpChksum, "eTlMmNfSylYVJIRuDI9cGB") == 0) {
          extern mxArray
            *sf_c4_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_third_party_uses_info
            (void);
          plhs[0] =
            sf_c4_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_third_party_uses_info();
          break;
        }
      }

     case 5:
      {
        if (strcmp(tpChksum, "CVEryNKHetbvSrLbrls") == 0) {
          extern mxArray
            *sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_third_party_uses_info
            (void);
          plhs[0] =
            sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_third_party_uses_info();
          break;
        }
      }

     default:
      plhs[0] = mxCreateDoubleMatrix(0,0,mxREAL);
    }
  }

  return 1;
}

void Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_debug_initialize(struct
  SfDebugInstanceStruct* debugInstance)
{
  _Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2MachineNumber_ =
    sf_debug_initialize_machine(debugInstance,
    "Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2","sfun",0,4,0,0,0);
  sf_debug_set_machine_event_thresholds(debugInstance,
    _Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2MachineNumber_,0,0);
  sf_debug_set_machine_data_thresholds(debugInstance,
    _Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2MachineNumber_,0);
}

void Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_register_exported_symbols(SimStruct*
  S)
{
}

static mxArray* sRtwOptimizationInfoStruct= NULL;
mxArray* load_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_optimization_info(void)
{
  if (sRtwOptimizationInfoStruct==NULL) {
    sRtwOptimizationInfoStruct = sf_load_rtw_optimization_info(
      "Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2",
      "Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2");
    mexMakeArrayPersistent(sRtwOptimizationInfoStruct);
  }

  return(sRtwOptimizationInfoStruct);
}

void unload_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_optimization_info(void)
{
  if (sRtwOptimizationInfoStruct!=NULL) {
    mxDestroyArray(sRtwOptimizationInfoStruct);
    sRtwOptimizationInfoStruct = NULL;
  }
}
