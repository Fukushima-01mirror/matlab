/* Include files */

#include <stddef.h>
#include "blas.h"
#include "Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_sfun.h"
#include "c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c(NULL,S);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
static void initialize_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void initialize_params_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void enable_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void disable_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static const mxArray *get_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void set_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c3_st);
static void finalize_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void sf_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void initSimStructsc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void registerMessagesc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c3_machineNumber, uint32_T
  c3_chartNumber);
static uint8_T c3_emlrt_marshallIn
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c3_b_is_active_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2, const
   char_T *c3_identifier);
static uint8_T c3_b_emlrt_marshallIn
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId);
static void init_dsm_address_info
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  chartInstance->c3_is_active_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2 = 0U;
}

static void initialize_params_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
}

static void enable_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void disable_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static const mxArray *get_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  const mxArray *c3_st = NULL;
  const mxArray *c3_y = NULL;
  uint8_T c3_u;
  const mxArray *c3_b_y = NULL;
  c3_st = NULL;
  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_createcellarray(1), FALSE);
  c3_u = chartInstance->c3_is_active_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  c3_b_y = NULL;
  sf_mex_assign(&c3_b_y, sf_mex_create("y", &c3_u, 3, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c3_y, 0, c3_b_y);
  sf_mex_assign(&c3_st, c3_y, FALSE);
  return c3_st;
}

static void set_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c3_st)
{
  const mxArray *c3_u;
  c3_u = sf_mex_dup(c3_st);
  chartInstance->c3_is_active_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2 =
    c3_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c3_u, 0)),
                        "is_active_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2");
  sf_mex_destroy(&c3_u);
  sf_mex_destroy(&c3_st);
}

static void finalize_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
}

static void sf_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  int32_T c3_i0;
  static char_T c3_cv0[2] = { 'o', 'n' };

  char_T c3_u[2];
  const mxArray *c3_y = NULL;
  real_T c3_b_u;
  const mxArray *c3_b_y = NULL;
  real_T c3_c_u;
  const mxArray *c3_c_y = NULL;
  real_T c3_d_u;
  const mxArray *c3_d_y = NULL;
  char_T c3_e_u;
  const mxArray *c3_e_y = NULL;
  static char_T c3_cv1[10] = { 'M', 'a', 'r', 'k', 'e', 'r', 'S', 'i', 'z', 'e'
  };

  char_T c3_f_u[10];
  const mxArray *c3_f_y = NULL;
  real_T c3_g_u;
  const mxArray *c3_g_y = NULL;
  char_T c3_h_u[2];
  const mxArray *c3_h_y = NULL;
  static char_T c3_cv2[6] = { 's', 'q', 'u', 'a', 'r', 'e' };

  char_T c3_i_u[6];
  const mxArray *c3_i_y = NULL;
  real_T c3_j_u;
  const mxArray *c3_j_y = NULL;
  real_T c3_k_u;
  const mxArray *c3_k_y = NULL;
  real_T c3_l_u[2];
  const mxArray *c3_l_y = NULL;
  real_T c3_m_u[2];
  const mxArray *c3_m_y = NULL;
  real_T c3_n_u[2];
  const mxArray *c3_n_y = NULL;
  static char_T c3_cv3[2] = { 'd', 'T' };

  char_T c3_o_u[2];
  const mxArray *c3_o_y = NULL;
  static char_T c3_cv4[4] = { 'd', 'A', '\x81', 'f' };

  char_T c3_p_u[4];
  const mxArray *c3_p_y = NULL;
  real_T *c3_u1;
  real_T *c3_u2;
  real_T *c3_q_u;
  c3_u2 = (real_T *)ssGetInputPortSignal(chartInstance->S, 2);
  c3_u1 = (real_T *)ssGetInputPortSignal(chartInstance->S, 1);
  c3_q_u = (real_T *)ssGetInputPortSignal(chartInstance->S, 0);
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  for (c3_i0 = 0; c3_i0 < 2; c3_i0++) {
    c3_u[c3_i0] = c3_cv0[c3_i0];
  }

  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_create("y", c3_u, 10, 0U, 1U, 0U, 2, 1, 2), FALSE);
  sf_mex_call("hold", 0U, 1U, 14, c3_y);
  c3_b_u = *c3_u1;
  c3_b_y = NULL;
  sf_mex_assign(&c3_b_y, sf_mex_create("y", &c3_b_u, 0, 0U, 0U, 0U, 0), FALSE);
  c3_c_u = *c3_u2;
  c3_c_y = NULL;
  sf_mex_assign(&c3_c_y, sf_mex_create("y", &c3_c_u, 0, 0U, 0U, 0U, 0), FALSE);
  c3_d_u = *c3_q_u;
  c3_d_y = NULL;
  sf_mex_assign(&c3_d_y, sf_mex_create("y", &c3_d_u, 0, 0U, 0U, 0U, 0), FALSE);
  c3_e_u = 'o';
  c3_e_y = NULL;
  sf_mex_assign(&c3_e_y, sf_mex_create("y", &c3_e_u, 10, 0U, 0U, 0U, 0), FALSE);
  for (c3_i0 = 0; c3_i0 < 10; c3_i0++) {
    c3_f_u[c3_i0] = c3_cv1[c3_i0];
  }

  c3_f_y = NULL;
  sf_mex_assign(&c3_f_y, sf_mex_create("y", c3_f_u, 10, 0U, 1U, 0U, 2, 1, 10),
                FALSE);
  c3_g_u = 2.0;
  c3_g_y = NULL;
  sf_mex_assign(&c3_g_y, sf_mex_create("y", &c3_g_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_call("plot3", 0U, 6U, 14, c3_b_y, 14, c3_c_y, 14, c3_d_y, 14, c3_e_y,
              14, c3_f_y, 14, c3_g_y);
  for (c3_i0 = 0; c3_i0 < 2; c3_i0++) {
    c3_h_u[c3_i0] = c3_cv0[c3_i0];
  }

  c3_h_y = NULL;
  sf_mex_assign(&c3_h_y, sf_mex_create("y", c3_h_u, 10, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call("grid", 0U, 1U, 14, c3_h_y);
  for (c3_i0 = 0; c3_i0 < 6; c3_i0++) {
    c3_i_u[c3_i0] = c3_cv2[c3_i0];
  }

  c3_i_y = NULL;
  sf_mex_assign(&c3_i_y, sf_mex_create("y", c3_i_u, 10, 0U, 1U, 0U, 2, 1, 6),
                FALSE);
  sf_mex_call("axis", 0U, 1U, 14, c3_i_y);
  c3_j_u = -30.0;
  c3_j_y = NULL;
  sf_mex_assign(&c3_j_y, sf_mex_create("y", &c3_j_u, 0, 0U, 0U, 0U, 0), FALSE);
  c3_k_u = 25.0;
  c3_k_y = NULL;
  sf_mex_assign(&c3_k_y, sf_mex_create("y", &c3_k_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_call("view", 0U, 2U, 14, c3_j_y, 14, c3_k_y);
  for (c3_i0 = 0; c3_i0 < 2; c3_i0++) {
    c3_l_u[c3_i0] = 600.0 * (real_T)c3_i0;
  }

  c3_l_y = NULL;
  sf_mex_assign(&c3_l_y, sf_mex_create("y", c3_l_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call("xlim", 0U, 1U, 14, c3_l_y);
  for (c3_i0 = 0; c3_i0 < 2; c3_i0++) {
    c3_m_u[c3_i0] = 600.0 * (real_T)c3_i0;
  }

  c3_m_y = NULL;
  sf_mex_assign(&c3_m_y, sf_mex_create("y", c3_m_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call("ylim", 0U, 1U, 14, c3_m_y);
  for (c3_i0 = 0; c3_i0 < 2; c3_i0++) {
    c3_n_u[c3_i0] = 5000.0 * (real_T)c3_i0;
  }

  c3_n_y = NULL;
  sf_mex_assign(&c3_n_y, sf_mex_create("y", c3_n_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call("zlim", 0U, 1U, 14, c3_n_y);
  for (c3_i0 = 0; c3_i0 < 2; c3_i0++) {
    c3_o_u[c3_i0] = c3_cv3[c3_i0];
  }

  c3_o_y = NULL;
  sf_mex_assign(&c3_o_y, sf_mex_create("y", c3_o_u, 10, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call("xlabel", 0U, 1U, 14, c3_o_y);
  for (c3_i0 = 0; c3_i0 < 4; c3_i0++) {
    c3_p_u[c3_i0] = c3_cv4[c3_i0];
  }

  c3_p_y = NULL;
  sf_mex_assign(&c3_p_y, sf_mex_create("y", c3_p_u, 10, 0U, 1U, 0U, 2, 1, 4),
                FALSE);
  sf_mex_call("ylabel", 0U, 1U, 14, c3_p_y);
}

static void initSimStructsc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
}

static void registerMessagesc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
}

static void init_script_number_translation(uint32_T c3_machineNumber, uint32_T
  c3_chartNumber)
{
}

const mxArray
  *sf_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c3_nameCaptureInfo;
  c3_ResolvedFunctionInfo c3_info[10];
  c3_ResolvedFunctionInfo (*c3_b_info)[10];
  const mxArray *c3_m0 = NULL;
  int32_T c3_i1;
  c3_ResolvedFunctionInfo *c3_r0;
  c3_nameCaptureInfo = NULL;
  c3_b_info = (c3_ResolvedFunctionInfo (*)[10])c3_info;
  (*c3_b_info)[0].context = "";
  (*c3_b_info)[0].name = "hold";
  (*c3_b_info)[0].dominantType = "char";
  (*c3_b_info)[0].resolved = "[IXE]$matlabroot$/toolbox/matlab/graphics/hold.m";
  (*c3_b_info)[0].fileTimeLo = 1305011098U;
  (*c3_b_info)[0].fileTimeHi = 0U;
  (*c3_b_info)[0].mFileTimeLo = 0U;
  (*c3_b_info)[0].mFileTimeHi = 0U;
  (*c3_b_info)[1].context = "";
  (*c3_b_info)[1].name = "plot3";
  (*c3_b_info)[1].dominantType = "double";
  (*c3_b_info)[1].resolved = "[IXMB]$matlabroot$/toolbox/matlab/graph3d/plot3";
  (*c3_b_info)[1].fileTimeLo = MAX_uint32_T;
  (*c3_b_info)[1].fileTimeHi = MAX_uint32_T;
  (*c3_b_info)[1].mFileTimeLo = MAX_uint32_T;
  (*c3_b_info)[1].mFileTimeHi = MAX_uint32_T;
  (*c3_b_info)[2].context = "";
  (*c3_b_info)[2].name = "grid";
  (*c3_b_info)[2].dominantType = "char";
  (*c3_b_info)[2].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph2d/grid.m";
  (*c3_b_info)[2].fileTimeLo = 1311230366U;
  (*c3_b_info)[2].fileTimeHi = 0U;
  (*c3_b_info)[2].mFileTimeLo = 0U;
  (*c3_b_info)[2].mFileTimeHi = 0U;
  (*c3_b_info)[3].context = "";
  (*c3_b_info)[3].name = "axis";
  (*c3_b_info)[3].dominantType = "char";
  (*c3_b_info)[3].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph2d/axis.m";
  (*c3_b_info)[3].fileTimeLo = 1344446932U;
  (*c3_b_info)[3].fileTimeHi = 0U;
  (*c3_b_info)[3].mFileTimeLo = 0U;
  (*c3_b_info)[3].mFileTimeHi = 0U;
  (*c3_b_info)[4].context = "";
  (*c3_b_info)[4].name = "view";
  (*c3_b_info)[4].dominantType = "double";
  (*c3_b_info)[4].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph3d/view.m";
  (*c3_b_info)[4].fileTimeLo = 1334046560U;
  (*c3_b_info)[4].fileTimeHi = 0U;
  (*c3_b_info)[4].mFileTimeLo = 0U;
  (*c3_b_info)[4].mFileTimeHi = 0U;
  (*c3_b_info)[5].context = "";
  (*c3_b_info)[5].name = "xlim";
  (*c3_b_info)[5].dominantType = "double";
  (*c3_b_info)[5].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph3d/xlim.m";
  (*c3_b_info)[5].fileTimeLo = 1299425202U;
  (*c3_b_info)[5].fileTimeHi = 0U;
  (*c3_b_info)[5].mFileTimeLo = 0U;
  (*c3_b_info)[5].mFileTimeHi = 0U;
  (*c3_b_info)[6].context = "";
  (*c3_b_info)[6].name = "ylim";
  (*c3_b_info)[6].dominantType = "double";
  (*c3_b_info)[6].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph3d/ylim.m";
  (*c3_b_info)[6].fileTimeLo = 1299425202U;
  (*c3_b_info)[6].fileTimeHi = 0U;
  (*c3_b_info)[6].mFileTimeLo = 0U;
  (*c3_b_info)[6].mFileTimeHi = 0U;
  (*c3_b_info)[7].context = "";
  (*c3_b_info)[7].name = "zlim";
  (*c3_b_info)[7].dominantType = "double";
  (*c3_b_info)[7].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph3d/zlim.m";
  (*c3_b_info)[7].fileTimeLo = 1299425202U;
  (*c3_b_info)[7].fileTimeHi = 0U;
  (*c3_b_info)[7].mFileTimeLo = 0U;
  (*c3_b_info)[7].mFileTimeHi = 0U;
  (*c3_b_info)[8].context = "";
  (*c3_b_info)[8].name = "xlabel";
  (*c3_b_info)[8].dominantType = "char";
  (*c3_b_info)[8].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph2d/xlabel.m";
  (*c3_b_info)[8].fileTimeLo = 1303531746U;
  (*c3_b_info)[8].fileTimeHi = 0U;
  (*c3_b_info)[8].mFileTimeLo = 0U;
  (*c3_b_info)[8].mFileTimeHi = 0U;
  (*c3_b_info)[9].context = "";
  (*c3_b_info)[9].name = "ylabel";
  (*c3_b_info)[9].dominantType = "char";
  (*c3_b_info)[9].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph2d/ylabel.m";
  (*c3_b_info)[9].fileTimeLo = 1303531746U;
  (*c3_b_info)[9].fileTimeHi = 0U;
  (*c3_b_info)[9].mFileTimeLo = 0U;
  (*c3_b_info)[9].mFileTimeHi = 0U;
  sf_mex_assign(&c3_m0, sf_mex_createstruct("nameCaptureInfo", 1, 10), FALSE);
  for (c3_i1 = 0; c3_i1 < 10; c3_i1++) {
    c3_r0 = &c3_info[c3_i1];
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", c3_r0->context, 15,
      0U, 0U, 0U, 2, 1, strlen(c3_r0->context)), "context", "nameCaptureInfo",
                    c3_i1);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", c3_r0->name, 15, 0U,
      0U, 0U, 2, 1, strlen(c3_r0->name)), "name", "nameCaptureInfo", c3_i1);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", c3_r0->dominantType,
      15, 0U, 0U, 0U, 2, 1, strlen(c3_r0->dominantType)), "dominantType",
                    "nameCaptureInfo", c3_i1);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", c3_r0->resolved, 15,
      0U, 0U, 0U, 2, 1, strlen(c3_r0->resolved)), "resolved", "nameCaptureInfo",
                    c3_i1);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", &c3_r0->fileTimeLo,
      7, 0U, 0U, 0U, 0), "fileTimeLo", "nameCaptureInfo", c3_i1);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", &c3_r0->fileTimeHi,
      7, 0U, 0U, 0U, 0), "fileTimeHi", "nameCaptureInfo", c3_i1);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", &c3_r0->mFileTimeLo,
      7, 0U, 0U, 0U, 0), "mFileTimeLo", "nameCaptureInfo", c3_i1);
    sf_mex_addfield(c3_m0, sf_mex_create("nameCaptureInfo", &c3_r0->mFileTimeHi,
      7, 0U, 0U, 0U, 0), "mFileTimeHi", "nameCaptureInfo", c3_i1);
  }

  sf_mex_assign(&c3_nameCaptureInfo, c3_m0, FALSE);
  sf_mex_emlrtNameCapturePostProcessR2012a(&c3_nameCaptureInfo);
  return c3_nameCaptureInfo;
}

static uint8_T c3_emlrt_marshallIn
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c3_b_is_active_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2, const
   char_T *c3_identifier)
{
  uint8_T c3_y;
  emlrtMsgIdentifier c3_thisId;
  c3_thisId.fIdentifier = c3_identifier;
  c3_thisId.fParent = NULL;
  c3_y = c3_b_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c3_b_is_active_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2), &c3_thisId);
  sf_mex_destroy(&c3_b_is_active_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2);
  return c3_y;
}

static uint8_T c3_b_emlrt_marshallIn
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId)
{
  uint8_T c3_y;
  uint8_T c3_u0;
  sf_mex_import(c3_parentId, sf_mex_dup(c3_u), &c3_u0, 1, 3, 0U, 0, 0U, 0);
  c3_y = c3_u0;
  sf_mex_destroy(&c3_u);
  return c3_y;
}

static void init_dsm_address_info
  (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
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

void sf_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(419306633U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(991143248U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2927855788U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(162848961U);
}

mxArray *sf_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_autoinheritance_info
  (void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,5,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("faAvVq9TJgOtMriGUElaQD");
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

mxArray *sf_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

static const mxArray
  *sf_get_sim_state_info_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S'type','srcId','name','auxInfo'{{M[8],M[0],T\"is_active_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 1, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "qCajjSBUvcAK4MozefnGZF";
}

static void sf_opaque_initialize_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  initialize_params_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
  initialize_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

static void sf_opaque_enable_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  enable_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

static void sf_opaque_disable_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  disable_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

static void sf_opaque_gateway_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  sf_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

extern const mxArray*
  sf_internal_get_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct*
  S)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_raw2high");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = (mxArray*) get_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInfo->chartInstance);        /* raw sim ctx */
  prhs[3] = (mxArray*)
    sf_get_sim_state_info_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2();/* state var info */
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

extern void sf_internal_set_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
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
    sf_get_sim_state_info_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_high2raw'.\n");
  }

  set_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInfo->chartInstance, mxDuplicateArray(plhs[0]));
  mxDestroyArray(plhs[0]);
}

static const mxArray*
  sf_opaque_get_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct* S)
{
  return sf_internal_get_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S);
}

static void sf_opaque_set_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SimStruct* S, const mxArray *st)
{
  sf_internal_set_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S, st);
}

static void sf_opaque_terminate_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_optimization_info();
    }

    finalize_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
      ((SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
       chartInstanceVar);
    utFree((void *)chartInstanceVar);
    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
      ((SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
       (((ChartInfoStruct *)ssGetUserData(S))->chartInstance));
  }
}

static void mdlSetWorkWidths_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct *
  S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct =
      load_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(S,sf_get_instance_specialization(),infoStruct,
      3);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(S,sf_get_instance_specialization(),
                infoStruct,3,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop(S,
      sf_get_instance_specialization(),infoStruct,3,
      "gatewayCannotBeInlinedMultipleTimes"));
    sf_update_buildInfo(S,sf_get_instance_specialization(),infoStruct,3);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 2, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,3,3);
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

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,3);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(4070897826U));
  ssSetChecksum1(S,(3465957343U));
  ssSetChecksum2(S,(404908932U));
  ssSetChecksum3(S,(490709178U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct *S)
{
  SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance;
  chartInstance = (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *)
    utMalloc(sizeof(SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct));
  memset(chartInstance, 0, sizeof
         (SFc3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW =
    mdlRTW_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.mdlStart =
    mdlStart_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
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
}

void c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_method_dispatcher(SimStruct *S,
  int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c3_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
