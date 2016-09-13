/* Include files */

#include <stddef.h>
#include "blas.h"
#include "Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_sfun.h"
#include "c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_sfun_debug_macros.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c(sfGlobalDebugInstanceStruct,S);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */
static const char * c2_debug_family_names[5] = { "nargin", "nargout", "u", "u1",
  "u2" };

/* Function Declarations */
static void initialize_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance);
static void initialize_params_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance);
static void enable_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance);
static void disable_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance);
static void c2_update_debugger_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance);
static void set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance, const
   mxArray *c2_st);
static void finalize_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance);
static void sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance);
static void initSimStructsc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance);
static void registerMessagesc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber);
static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, void *c2_inData);
static real_T c2_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static int32_T c2_b_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static uint8_T c2_c_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance, const
   mxArray *c2_b_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV, const char_T
   *c2_identifier);
static uint8_T c2_d_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void init_dsm_address_info
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance)
{
  chartInstance->c2_sfEvent = CALL_EVENT;
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  chartInstance->c2_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV = 0U;
}

static void initialize_params_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance)
{
}

static void enable_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void disable_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void c2_update_debugger_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance)
{
}

static const mxArray *get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance)
{
  const mxArray *c2_st;
  const mxArray *c2_y = NULL;
  uint8_T c2_hoistedGlobal;
  uint8_T c2_u;
  const mxArray *c2_b_y = NULL;
  c2_st = NULL;
  c2_st = NULL;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_createcellarray(1), FALSE);
  c2_hoistedGlobal =
    chartInstance->c2_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV;
  c2_u = c2_hoistedGlobal;
  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", &c2_u, 3, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c2_y, 0, c2_b_y);
  sf_mex_assign(&c2_st, c2_y, FALSE);
  return c2_st;
}

static void set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance, const
   mxArray *c2_st)
{
  const mxArray *c2_u;
  chartInstance->c2_doneDoubleBufferReInit = TRUE;
  c2_u = sf_mex_dup(c2_st);
  chartInstance->c2_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV =
    c2_c_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 0)),
    "is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV");
  sf_mex_destroy(&c2_u);
  c2_update_debugger_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(chartInstance);
  sf_mex_destroy(&c2_st);
}

static void finalize_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance)
{
}

static void sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance)
{
  real_T c2_hoistedGlobal;
  real_T c2_b_hoistedGlobal;
  real_T c2_c_hoistedGlobal;
  real_T c2_u;
  real_T c2_u1;
  real_T c2_u2;
  uint32_T c2_debug_family_var_map[5];
  real_T c2_nargin = 3.0;
  real_T c2_nargout = 0.0;
  int32_T c2_i0;
  static char_T c2_cv0[2] = { 'o', 'n' };

  char_T c2_b_u[2];
  const mxArray *c2_y = NULL;
  real_T c2_c_u;
  const mxArray *c2_b_y = NULL;
  real_T c2_d_u;
  const mxArray *c2_c_y = NULL;
  real_T c2_e_u;
  const mxArray *c2_d_y = NULL;
  char_T c2_f_u;
  const mxArray *c2_e_y = NULL;
  int32_T c2_i1;
  static char_T c2_cv1[10] = { 'M', 'a', 'r', 'k', 'e', 'r', 'S', 'i', 'z', 'e'
  };

  char_T c2_g_u[10];
  const mxArray *c2_f_y = NULL;
  real_T c2_h_u;
  const mxArray *c2_g_y = NULL;
  real_T *c2_i_u;
  real_T *c2_b_u1;
  real_T *c2_b_u2;
  c2_b_u2 = (real_T *)ssGetInputPortSignal(chartInstance->S, 2);
  c2_b_u1 = (real_T *)ssGetInputPortSignal(chartInstance->S, 1);
  c2_i_u = (real_T *)ssGetInputPortSignal(chartInstance->S, 0);
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 1U, chartInstance->c2_sfEvent);
  _SFD_DATA_RANGE_CHECK(*c2_i_u, 0U);
  _SFD_DATA_RANGE_CHECK(*c2_b_u1, 1U);
  _SFD_DATA_RANGE_CHECK(*c2_b_u2, 2U);
  chartInstance->c2_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 1U, chartInstance->c2_sfEvent);
  c2_hoistedGlobal = *c2_i_u;
  c2_b_hoistedGlobal = *c2_b_u1;
  c2_c_hoistedGlobal = *c2_b_u2;
  c2_u = c2_hoistedGlobal;
  c2_u1 = c2_b_hoistedGlobal;
  c2_u2 = c2_c_hoistedGlobal;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 5U, 5U, c2_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 0U, c2_sf_marshallOut,
    c2_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 1U, c2_sf_marshallOut,
    c2_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_u, 2U, c2_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_u1, 3U, c2_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_u2, 4U, c2_sf_marshallOut);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 5);
  for (c2_i0 = 0; c2_i0 < 2; c2_i0++) {
    c2_b_u[c2_i0] = c2_cv0[c2_i0];
  }

  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", c2_b_u, 10, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call_debug("hold", 0U, 1U, 14, c2_y);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 6);
  c2_c_u = c2_u1;
  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", &c2_c_u, 0, 0U, 0U, 0U, 0), FALSE);
  c2_d_u = c2_u2;
  c2_c_y = NULL;
  sf_mex_assign(&c2_c_y, sf_mex_create("y", &c2_d_u, 0, 0U, 0U, 0U, 0), FALSE);
  c2_e_u = c2_u;
  c2_d_y = NULL;
  sf_mex_assign(&c2_d_y, sf_mex_create("y", &c2_e_u, 0, 0U, 0U, 0U, 0), FALSE);
  c2_f_u = 'o';
  c2_e_y = NULL;
  sf_mex_assign(&c2_e_y, sf_mex_create("y", &c2_f_u, 10, 0U, 0U, 0U, 0), FALSE);
  for (c2_i1 = 0; c2_i1 < 10; c2_i1++) {
    c2_g_u[c2_i1] = c2_cv1[c2_i1];
  }

  c2_f_y = NULL;
  sf_mex_assign(&c2_f_y, sf_mex_create("y", c2_g_u, 10, 0U, 1U, 0U, 2, 1, 10),
                FALSE);
  c2_h_u = 2.0;
  c2_g_y = NULL;
  sf_mex_assign(&c2_g_y, sf_mex_create("y", &c2_h_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_call_debug("plot3", 0U, 6U, 14, c2_b_y, 14, c2_c_y, 14, c2_d_y, 14,
                    c2_e_y, 14, c2_f_y, 14, c2_g_y);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, -6);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 1U, chartInstance->c2_sfEvent);
  _SFD_CHECK_FOR_STATE_INCONSISTENCY
    (_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVMachineNumber_,
     chartInstance->chartNumber, chartInstance->instanceNumber);
}

static void initSimStructsc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance)
{
}

static void registerMessagesc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance)
{
}

static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber)
{
}

static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, void *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  real_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance;
  chartInstance = (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *)
    chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_u = *(real_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static real_T c2_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  real_T c2_y;
  real_T c2_d0;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_d0, 1, 0, 0U, 0, 0U, 0);
  c2_y = c2_d0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_nargout;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y;
  SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance;
  chartInstance = (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *)
    chartInstanceVoid;
  c2_nargout = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_nargout), &c2_thisId);
  sf_mex_destroy(&c2_nargout);
  *(real_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

const mxArray
  *sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c2_nameCaptureInfo;
  c2_ResolvedFunctionInfo c2_info[2];
  c2_ResolvedFunctionInfo (*c2_b_info)[2];
  const mxArray *c2_m0 = NULL;
  int32_T c2_i2;
  c2_ResolvedFunctionInfo *c2_r0;
  c2_nameCaptureInfo = NULL;
  c2_nameCaptureInfo = NULL;
  c2_b_info = (c2_ResolvedFunctionInfo (*)[2])c2_info;
  (*c2_b_info)[0].context = "";
  (*c2_b_info)[0].name = "hold";
  (*c2_b_info)[0].dominantType = "char";
  (*c2_b_info)[0].resolved = "[IXE]$matlabroot$/toolbox/matlab/graphics/hold.m";
  (*c2_b_info)[0].fileTimeLo = 1305011098U;
  (*c2_b_info)[0].fileTimeHi = 0U;
  (*c2_b_info)[0].mFileTimeLo = 0U;
  (*c2_b_info)[0].mFileTimeHi = 0U;
  (*c2_b_info)[1].context = "";
  (*c2_b_info)[1].name = "plot3";
  (*c2_b_info)[1].dominantType = "double";
  (*c2_b_info)[1].resolved = "[IXMB]$matlabroot$/toolbox/matlab/graph3d/plot3";
  (*c2_b_info)[1].fileTimeLo = MAX_uint32_T;
  (*c2_b_info)[1].fileTimeHi = MAX_uint32_T;
  (*c2_b_info)[1].mFileTimeLo = MAX_uint32_T;
  (*c2_b_info)[1].mFileTimeHi = MAX_uint32_T;
  sf_mex_assign(&c2_m0, sf_mex_createstruct("nameCaptureInfo", 1, 2), FALSE);
  for (c2_i2 = 0; c2_i2 < 2; c2_i2++) {
    c2_r0 = &c2_info[c2_i2];
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->context, 15,
      0U, 0U, 0U, 2, 1, strlen(c2_r0->context)), "context", "nameCaptureInfo",
                    c2_i2);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->name, 15, 0U,
      0U, 0U, 2, 1, strlen(c2_r0->name)), "name", "nameCaptureInfo", c2_i2);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->dominantType,
      15, 0U, 0U, 0U, 2, 1, strlen(c2_r0->dominantType)), "dominantType",
                    "nameCaptureInfo", c2_i2);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->resolved, 15,
      0U, 0U, 0U, 2, 1, strlen(c2_r0->resolved)), "resolved", "nameCaptureInfo",
                    c2_i2);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->fileTimeLo,
      7, 0U, 0U, 0U, 0), "fileTimeLo", "nameCaptureInfo", c2_i2);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->fileTimeHi,
      7, 0U, 0U, 0U, 0), "fileTimeHi", "nameCaptureInfo", c2_i2);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->mFileTimeLo,
      7, 0U, 0U, 0U, 0), "mFileTimeLo", "nameCaptureInfo", c2_i2);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->mFileTimeHi,
      7, 0U, 0U, 0U, 0), "mFileTimeHi", "nameCaptureInfo", c2_i2);
  }

  sf_mex_assign(&c2_nameCaptureInfo, c2_m0, FALSE);
  sf_mex_emlrtNameCapturePostProcessR2012a(&c2_nameCaptureInfo);
  return c2_nameCaptureInfo;
}

static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance;
  chartInstance = (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *)
    chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_u = *(int32_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 6, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, FALSE);
  return c2_mxArrayOutData;
}

static int32_T c2_b_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  int32_T c2_y;
  int32_T c2_i3;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_i3, 1, 6, 0U, 0, 0U, 0);
  c2_y = c2_i3;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_b_sfEvent;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  int32_T c2_y;
  SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance;
  chartInstance = (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *)
    chartInstanceVoid;
  c2_b_sfEvent = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_b_sfEvent),
    &c2_thisId);
  sf_mex_destroy(&c2_b_sfEvent);
  *(int32_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

static uint8_T c2_c_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance, const
   mxArray *c2_b_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV, const char_T
   *c2_identifier)
{
  uint8_T c2_y;
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_d_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c2_b_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV), &c2_thisId);
  sf_mex_destroy(&c2_b_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV);
  return c2_y;
}

static uint8_T c2_d_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  uint8_T c2_y;
  uint8_T c2_u0;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_u0, 1, 3, 0U, 0, 0U, 0);
  c2_y = c2_u0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void init_dsm_address_info
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance)
{
}

/* SFunction Glue Code */
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

void sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(940074406U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(581181846U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2913247752U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(3066230482U);
}

mxArray *sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_get_autoinheritance_info
  (void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,5,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("qAST1o6NR8bHZXjhViQDlF");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,3,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,2,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,2,"type",mxType);
    }

    mxSetField(mxData,2,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

static const mxArray
  *sf_get_sim_state_info_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S'type','srcId','name','auxInfo'{{M[8],M[0],T\"is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 1, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance;
    chartInstance = (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *)
      ((ChartInfoStruct *)(ssGetUserData(S)))->chartInstance;
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVMachineNumber_,
           2,
           1,
           1,
           3,
           0,
           0,
           0,
           0,
           0,
           &(chartInstance->chartNumber),
           &(chartInstance->instanceNumber),
           ssGetPath(S),
           (void *)S);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          init_script_number_translation
            (_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVMachineNumber_,
             chartInstance->chartNumber);
          sf_debug_set_chart_disable_implicit_casting
            (sfGlobalDebugInstanceStruct,
             _Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVMachineNumber_,
             chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds(sfGlobalDebugInstanceStruct,
            _Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVMachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,1,1,0,"u");
          _SFD_SET_DATA_PROPS(1,1,1,0,"u1");
          _SFD_SET_DATA_PROPS(2,1,1,0,"u2");
          _SFD_STATE_INFO(0,0,2);
          _SFD_CH_SUBSTATE_COUNT(0);
          _SFD_CH_SUBSTATE_DECOMP(0);
        }

        _SFD_CV_INIT_CHART(0,0,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);

        /* Initialization of MATLAB Function Model Coverage */
        _SFD_CV_INIT_EML(0,1,1,0,0,0,0,0,0,0,0);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,103);
        _SFD_TRANS_COV_WTS(0,0,0,1,0);
        if (chartAlreadyPresent==0) {
          _SFD_TRANS_COV_MAPS(0,
                              0,NULL,NULL,
                              0,NULL,NULL,
                              1,NULL,NULL,
                              0,NULL,NULL);
        }

        _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c2_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c2_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(2,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c2_sf_marshallOut,(MexInFcnForType)NULL);

        {
          real_T *c2_u;
          real_T *c2_u1;
          real_T *c2_u2;
          c2_u2 = (real_T *)ssGetInputPortSignal(chartInstance->S, 2);
          c2_u1 = (real_T *)ssGetInputPortSignal(chartInstance->S, 1);
          c2_u = (real_T *)ssGetInputPortSignal(chartInstance->S, 0);
          _SFD_SET_DATA_VALUE_PTR(0U, c2_u);
          _SFD_SET_DATA_VALUE_PTR(1U, c2_u1);
          _SFD_SET_DATA_VALUE_PTR(2U, c2_u2);
        }
      }
    } else {
      sf_debug_reset_current_state_configuration(sfGlobalDebugInstanceStruct,
        _Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVMachineNumber_,
        chartInstance->chartNumber,chartInstance->instanceNumber);
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "a8oqZoMQPMQ2trjk7fLN8C";
}

static void sf_opaque_initialize_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(void
  *chartInstanceVar)
{
  chart_debug_initialization
    (((SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct*)
      chartInstanceVar)->S,0);
  initialize_params_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct*) chartInstanceVar);
  initialize_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(void
  *chartInstanceVar)
{
  enable_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(void
  *chartInstanceVar)
{
  disable_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(void
  *chartInstanceVar)
{
  sf_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct*) chartInstanceVar);
}

extern const mxArray*
  sf_internal_get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(SimStruct* S)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_raw2high");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = (mxArray*) get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct*)
     chartInfo->chartInstance);        /* raw sim ctx */
  prhs[3] = (mxArray*)
    sf_get_sim_state_info_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_raw2high'.\n");
  }

  return plhs[0];
}

extern void sf_internal_set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SimStruct* S, const mxArray *st)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_high2raw");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = mxDuplicateArray(st);      /* high level simctx */
  prhs[3] = (mxArray*)
    sf_get_sim_state_info_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_high2raw'.\n");
  }

  set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct*)
     chartInfo->chartInstance, mxDuplicateArray(plhs[0]));
  mxDestroyArray(plhs[0]);
}

static const mxArray*
  sf_opaque_get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(SimStruct* S)
{
  return sf_internal_get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(S);
}

static void sf_opaque_set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SimStruct* S, const mxArray *st)
{
  sf_internal_set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(S, st);
}

static void sf_opaque_terminate_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_optimization_info();
    }

    finalize_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
      ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct*)
       chartInstanceVar);
    utFree((void *)chartInstanceVar);
    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
      ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct*)
       (((ChartInfoStruct *)ssGetUserData(S))->chartInstance));
  }
}

static void mdlSetWorkWidths_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(SimStruct
  *S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct =
      load_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(S,sf_get_instance_specialization(),infoStruct,
      2);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(S,sf_get_instance_specialization(),
                infoStruct,2,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop(S,
      sf_get_instance_specialization(),infoStruct,2,
      "gatewayCannotBeInlinedMultipleTimes"));
    sf_update_buildInfo(S,sf_get_instance_specialization(),infoStruct,2);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 2, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,2,3);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=0; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 3; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,2);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(1817371654U));
  ssSetChecksum1(S,(1600433558U));
  ssSetChecksum2(S,(2163667426U));
  ssSetChecksum3(S,(2650905949U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(SimStruct *S)
{
  SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *chartInstance;
  chartInstance = (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct *)
    utMalloc(sizeof(SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct));
  memset(chartInstance, 0, sizeof
         (SFc2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW =
    mdlRTW_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV;
  chartInstance->chartInfo.mdlStart =
    mdlStart_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->S = S;
  ssSetUserData(S,(void *)(&(chartInstance->chartInfo)));/* register the chart instance with simstruct */
  init_dsm_address_info(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  sf_opaque_init_subchart_simstructs(chartInstance->chartInfo.chartInstance);
  chart_debug_initialization(S,1);
}

void c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_method_dispatcher(SimStruct *S,
  int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c2_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
