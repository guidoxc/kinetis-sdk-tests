/******************************************************************************
*
* (c) Copyright 2013, Freescale
*
******************************************************************************/
/*!
*
* @file       GDFLIB_FilterIIR2.h
*
* @version    1.0.1.0
*
* @date       Oct-9-2013
*
* @brief      Header file for GDFLIB_FilterIIR2 function
*
******************************************************************************/
#ifndef GDFLIB_FILTERIIR2_H
#define GDFLIB_FILTERIIR2_H

#ifdef __cplusplus
extern "C" {
#endif

/**
* @page misra_violations MISRA-C:2004 violations
*
* @section GDFLIB_FilterIIR2_h_REF_1
* Violates MISRA 2004 Required Rule 19.4, Disallowed definition for macro.
* To allow the user utilize the benefits of using all three supported implementation of each
* function in user application, the macro dispatcher inevitably requires use of disallowed macro
* definition.
*
* @section GDFLIB_FilterIIR2_h_REF_2
* Violates MISRA 2004 Advisory Rule 19.7, Function-like macro defined.
* To allow the user utilize the benefits of using all three supported implementation of each
* function in user application, the macro dispatcher inevitably requires the function-like macro
* definition.
*
* @section GDFLIB_FilterIIR2_h_REF_3
* Violates MISRA 2004 Required Rule 19.10, Unparenthesized macro parameter in definition of macro.
* To allow the user utilize the benefits of using all three supported implementation of each
* function in user application, the macro dispatcher inevitably requires use of unparenthesized
* macro parameters.
*
* @section GDFLIB_FilterIIR2_h_REF_4
* Violates MISRA 2004 Advisory Rule 19.13, #/##' operator used in macro.
* To allow the user utilize the benefits of using all three supported implementation of each
* function in user application, the macro dispatcher inevitably requires use of '#/##' operators.
*/
#include "SWLIBS_Typedefs.h"
#include "SWLIBS_Defines.h"
#include "SWLIBS_MacroDisp.h"
#include "mlib.h"

/****************************************************************************
* Defines and macros            (scope: module-local)
****************************************************************************/
#ifndef _MATLAB_BAM_CREATE
  /*
  * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
  * for macro.
  * @violates @ref GDFLIB_FilterIIR2_h_REF_2 MISRA 2004 Advisory Rule 19.7, Function-like macro
  * defined.
  * @violates @ref GDFLIB_FilterIIR2_h_REF_3 MISRA 2004 Required Rule 19.10, Unparenthesized macro
  * parameter in definition of macro.
  */
  #define GDFLIB_FilterIIR2Init(...)     macro_dispatcher(GDFLIB_FilterIIR2Init, __VA_ARGS__)(__VA_ARGS__)     /*!< This function initializes the second order IIR filter buffers. */
  /*
  * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
  * for macro.
  * @violates @ref GDFLIB_FilterIIR2_h_REF_2 MISRA 2004 Advisory Rule 19.7, Function-like macro
  * defined.
  * @violates @ref GDFLIB_FilterIIR2_h_REF_3 MISRA 2004 Required Rule 19.10, Unparenthesized macro
  * parameter in definition of macro.
  */
  #define GDFLIB_FilterIIR2(...)         macro_dispatcher(GDFLIB_FilterIIR2, __VA_ARGS__)(__VA_ARGS__)         /*!< This function implements the second order IIR filter. */

  #if (SWLIBS_DEFAULT_IMPLEMENTATION == SWLIBS_DEFAULT_IMPLEMENTATION_F32)
    /*
    * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
    * for macro.
    */
    #define GDFLIB_FILTER_IIR2_T                        GDFLIB_FILTER_IIR2_T_F32                        /*!< Definition of GDFLIB_FILTER_IIR2_T as alias for GDFLIB_FILTER_IIR2_T_F32 datatype in case the 32-bit fractional implementation is selected. */
    /*
    * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
    * for macro.
    */
    #define GDFLIB_FILTER_IIR2_DEFAULT                  GDFLIB_FILTER_IIR2_DEFAULT_F32                  /*!< Definition of GDFLIB_FILTER_IIR2_DEFAULT as alias for GDFLIB_FILTER_IIR2_DEFAULT_F32 default value in case the 32-bit fractional implementation is selected. */
    /*
    * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
    * for macro.
    * @violates @ref GDFLIB_FilterIIR2_h_REF_2 MISRA 2004 Advisory Rule 19.7, Function-like macro
    * defined.
    * @violates @ref GDFLIB_FilterIIR2_h_REF_3 MISRA 2004 Required Rule 19.10, Unparenthesized macro
    * parameter in definition of macro.
    */
    /** @remarks Implements DGDFLIB00060 */
    #define GDFLIB_FilterIIR2Init_Dsptchr_1(pParam)     GDFLIB_FilterIIR2Init_Dsptchr_2(pParam,F32)     /*!< Function dispatcher for GDFLIB_FilterIIR2Init_Dsptchr_1, do not modify!!! */
    /*
    * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
    * for macro.
    * @violates @ref GDFLIB_FilterIIR2_h_REF_2 MISRA 2004 Advisory Rule 19.7, Function-like macro
    * defined.
    * @violates @ref GDFLIB_FilterIIR2_h_REF_3 MISRA 2004 Required Rule 19.10, Unparenthesized macro
    * parameter in definition of macro.
    */
    /** @remarks Implements DGDFLIB00043 */
    #define GDFLIB_FilterIIR2_Dsptchr_2(In,pParam)      GDFLIB_FilterIIR2_Dsptchr_3(In,pParam,F32)      /*!< Function dispatcher for GDFLIB_FilterIIR2_Dsptchr_2, do not modify!!! */
  #endif
  #if (SWLIBS_DEFAULT_IMPLEMENTATION == SWLIBS_DEFAULT_IMPLEMENTATION_F16)
    /*
    * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
    * for macro.
    */
    #define GDFLIB_FILTER_IIR2_T                        GDFLIB_FILTER_IIR2_T_F16                        /*!< Definition of GDFLIB_FILTER_IIR2_T as alias for GDFLIB_FILTER_IIR2_T_F16 datatype in case the 16-bit fractional implementation is selected. */
    /*
    * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
    * for macro.
    */
    #define GDFLIB_FILTER_IIR2_DEFAULT                  GDFLIB_FILTER_IIR2_DEFAULT_F16                  /*!< Definition of GDFLIB_FILTER_IIR2_DEFAULT GDFLIB_FILTER_IIR2_DEFAULT_F16 default value in case the 16-bit fractional implementation is selected. */
    /*
    * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
    * for macro.
    * @violates @ref GDFLIB_FilterIIR2_h_REF_2 MISRA 2004 Advisory Rule 19.7, Function-like macro
    * defined.
    * @violates @ref GDFLIB_FilterIIR2_h_REF_3 MISRA 2004 Required Rule 19.10, Unparenthesized macro
    * parameter in definition of macro.
    */
    /** @remarks Implements DGDFLIB00060 */
    #define GDFLIB_FilterIIR2Init_Dsptchr_1(pParam)     GDFLIB_FilterIIR2Init_Dsptchr_2(pParam,F16)     /*!< Function dispatcher for GDFLIB_FilterIIR2Init_Dsptchr_1, do not modify!!! */
    /*
    * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
    * for macro.
    * @violates @ref GDFLIB_FilterIIR2_h_REF_2 MISRA 2004 Advisory Rule 19.7, Function-like macro
    * defined.
    * @violates @ref GDFLIB_FilterIIR2_h_REF_3 MISRA 2004 Required Rule 19.10, Unparenthesized macro
    * parameter in definition of macro.
    */
    /** @remarks Implements DGDFLIB00043 */
    #define GDFLIB_FilterIIR2_Dsptchr_2(In,pParam)      GDFLIB_FilterIIR2_Dsptchr_3(In,pParam,F16)      /*!< Function dispatcher for GDFLIB_FilterIIR2_Dsptchr_2, do not modify!!! */
  #endif

  /*
  * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
  * for macro.
  * @violates @ref GDFLIB_FilterIIR2_h_REF_2 MISRA 2004 Advisory Rule 19.7, Function-like macro
  * defined.
  * @violates @ref GDFLIB_FilterIIR2_h_REF_3 MISRA 2004 Required Rule 19.10, Unparenthesized macro
  * parameter in definition of macro.
  */
  #define GDFLIB_FilterIIR2Init_Dsptchr_2(pParam,Impl)    GDFLIB_FilterIIR2Init_Dsptchr_(pParam,Impl)     /*!< Function dispatcher for GDFLIB_FilterIIR2Init_Dsptchr_2, do not modify!!! */
  /*
  * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
  * for macro.
  * @violates @ref GDFLIB_FilterIIR2_h_REF_2 MISRA 2004 Advisory Rule 19.7, Function-like macro
  * defined.
  * @violates @ref GDFLIB_FilterIIR2_h_REF_4 MISRA 2004 Advisory Rule 19.13, #/##' operator used in
  * macro.
  */
  /** @remarks Implements DGDFLIB00067 */
  #define GDFLIB_FilterIIR2Init_Dsptchr_(pParam,Impl)     GDFLIB_FilterIIR2Init_##Impl(pParam)            /*!< Function dispatcher for GDFLIB_FilterIIR2Init_Dsptchr_, do not modify!!! */

  /*
  * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
  * for macro.
  * @violates @ref GDFLIB_FilterIIR2_h_REF_2 MISRA 2004 Advisory Rule 19.7, Function-like macro
  * defined.
  * @violates @ref GDFLIB_FilterIIR2_h_REF_3 MISRA 2004 Required Rule 19.10, Unparenthesized macro
  * parameter in definition of macro.
  */
  #define GDFLIB_FilterIIR2_Dsptchr_3(In,pParam,Impl)     GDFLIB_FilterIIR2_Dsptchr_(In,pParam,Impl)      /*!< Function dispatcher for GDFLIB_FilterIIR2_Dsptchr_3, do not modify!!! */
  /*
  * @violates @ref GDFLIB_FilterIIR2_h_REF_1 MISRA 2004 Required Rule 19.4, Disallowed definition
  * for macro.
  * @violates @ref GDFLIB_FilterIIR2_h_REF_2 MISRA 2004 Advisory Rule 19.7, Function-like macro
  * defined.
  * @violates @ref GDFLIB_FilterIIR2_h_REF_3 MISRA 2004 Required Rule 19.10, Unparenthesized macro
  * parameter in definition of macro.
  * @violates @ref GDFLIB_FilterIIR2_h_REF_4 MISRA 2004 Advisory Rule 19.13, #/##' operator used in
  * macro.
  */
  /** @remarks Implements DGDFLIB00054 */
  #define GDFLIB_FilterIIR2_Dsptchr_(In,pParam,Impl)      GDFLIB_FilterIIR2_##Impl(In,pParam)             /*!< Function dispatcher for GDFLIB_FilterIIR2_Dsptchr_, do not modify!!! */
#endif /* _MATLAB_BAM_CREATE */

/****************************************************************************
* Typedefs and structures       (scope: module-local)
****************************************************************************/




/****************************************************************************
* Implementation variant: 32-bit fractional
****************************************************************************/
#if (SWLIBS_SUPPORT_F32 == SWLIBS_STD_ON)
  #define GDFLIB_FILTER_IIR2_DEFAULT_F32 {{0,0,0,0,0},{0,0},{0,0}}     /*!< Default value for GDFLIB_FILTER_IIR2_T_F32. */

  /*************************************************************************/
  /*!
  @struct GDFLIB_FILTER_IIR2_COEFF_T_F32 "\GDFLIB_FilterIIR2.h"

  @brief  Sub-structure containing filter coefficients.
  *//***********************************************************************/
  /** @remarks Implements DGDFLIB00048 */
  typedef struct{
    Frac32 f32B0; /*!< B0 coefficient of an IIR2 filter, fractional format normalized to fit into (-2\f$^{31}\f$, 2\f$^{31}\f$-1). */
    Frac32 f32B1; /*!< B1 coefficient of an IIR2 filter, fractional format normalized to fit into (-2\f$^{31}\f$, 2\f$^{31}\f$-1). */
    Frac32 f32B2; /*!< B2 coefficient of an IIR2 filter, fractional format normalized to fit into (-2\f$^{31}\f$, 2\f$^{31}\f$-1). */
    Frac32 f32A1; /*!< A1 coefficient of an IIR2 filter, fractional format normalized to fit into (-2\f$^{31}\f$, 2\f$^{31}\f$-1). */
    Frac32 f32A2; /*!< A2 coefficient of an IIR2 filter, fractional format normalized to fit into (-2\f$^{31}\f$, 2\f$^{31}\f$-1). */
  }GDFLIB_FILTER_IIR2_COEFF_T_F32;

  /*************************************************************************/
  /*!
  @struct GDFLIB_FILTER_IIR2_T_F32 "\GDFLIB_FilterIIR2.h"

  @brief  Structure containing filter buffer and coefficients.
  *//***********************************************************************/
  /** @remarks Implements DGDFLIB00051, DGDFLIB00052, DGDFLIB00065, DGDFLIB00062, DGDFLIB00059, DGDFLIB00045 */
  typedef struct{
    GDFLIB_FILTER_IIR2_COEFF_T_F32 trFiltCoeff; /*!< Sub-structure containing filter coefficients. */
    Frac32 f32FiltBufferX[2]; /*!< Input buffer of an IIR2 filter, fractional format normalized to fit into (-2\f$^{31}\f$, 2\f$^{31}\f$-1). */
    Frac32 f32FiltBufferY[2]; /*!< Internal accumulator buffer, fractional format normalized to fit into (-2\f$^{31}\f$, 2\f$^{31}\f$-1). */
  }GDFLIB_FILTER_IIR2_T_F32;

/****************************************************************************
* Exported function prototypes
****************************************************************************/
  extern void GDFLIB_FilterIIR2Init_F32(GDFLIB_FILTER_IIR2_T_F32 * const pParam);
  extern Frac32 GDFLIB_FilterIIR2_F32(Frac32 f32In,GDFLIB_FILTER_IIR2_T_F32 * const pParam);
#endif /* SWLIBS_SUPPORT_F32 == SWLIBS_STD_ON */




/****************************************************************************
* Implementation variant: 16-bit fractional
****************************************************************************/
#if (SWLIBS_SUPPORT_F16 == SWLIBS_STD_ON)
  #define GDFLIB_FILTER_IIR2_DEFAULT_F16 {{0,0,0,0,0},{0,0},{0,0}}     /*!< Default value for GDFLIB_FILTER_IIR2_T_F16. */

  /*************************************************************************/
  /*!
  @struct GDFLIB_FILTER_IIR2_COEFF_T_F16 "\GDFLIB_FilterIIR2.h"

  @brief  Sub-structure containing filter coefficients.
  *//***********************************************************************/
  /** @remarks Implements DGDFLIB00049 */
  typedef struct{
    Frac16 f16B0; /*!< B0 coefficient of an IIR2 filter, fractional format normalized to fit into (-2\f$^{15}\f$, 2\f$^{15}\f$-1). */
    Frac16 f16B1; /*!< B1 coefficient of an IIR2 filter, fractional format normalized to fit into (-2\f$^{15}\f$, 2\f$^{15}\f$-1). */
    Frac16 f16B2; /*!< B2 coefficient of an IIR2 filter, fractional format normalized to fit into (-2\f$^{15}\f$, 2\f$^{15}\f$-1). */
    Frac16 f16A1; /*!< A1 coefficient of an IIR2 filter, fractional format normalized to fit into (-2\f$^{15}\f$, 2\f$^{15}\f$-1). */
    Frac16 f16A2; /*!< A2 coefficient of an IIR2 filter, fractional format normalized to fit into (-2\f$^{15}\f$, 2\f$^{15}\f$-1). */
  }GDFLIB_FILTER_IIR2_COEFF_T_F16;

  /*************************************************************************/
  /*!
  @struct GDFLIB_FILTER_IIR2_T_F16 "\GDFLIB_FilterIIR2.h"

  @brief  Structure containing filter buffer and coefficients.
  *//***********************************************************************/
  /** @remarks Implements DGDFLIB00051, DGDFLIB00052, DGDFLIB00065, DGDFLIB00063, DGDFLIB00059, DGDFLIB00046 */
  typedef struct{
    GDFLIB_FILTER_IIR2_COEFF_T_F16 trFiltCoeff; /*!< Sub-structure containing filter coefficients. */
    Frac16 f16FiltBufferX[2]; /*!< Input buffer of an IIR2 filter, fractional format normalized to fit into (-2\f$^{15}\f$, 2\f$^{15}\f$-1). */
    Frac32 f32FiltBufferY[2]; /*!< Internal accumulator buffer, fractional format normalized to fit into (-2\f$^{15}\f$, 2\f$^{15}\f$-1). */
  }GDFLIB_FILTER_IIR2_T_F16;

/****************************************************************************
* Exported function prototypes
****************************************************************************/
  extern void GDFLIB_FilterIIR2Init_F16(GDFLIB_FILTER_IIR2_T_F16 * const pParam);
  extern Frac16 GDFLIB_FilterIIR2_F16(Frac16 f16In,GDFLIB_FILTER_IIR2_T_F16 * const pParam);
#endif /* SWLIBS_SUPPORT_F16 == SWLIBS_STD_ON */




#ifdef __cplusplus
}
#endif

#endif /* GDFLIB_FILTERIIR2_H */
