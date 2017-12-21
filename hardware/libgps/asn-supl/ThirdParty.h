/*
 * Generated by asn1c-0.9.28 (http://lionet.info/asn1c)
 * From ASN.1 module "Ver2-ULP-Components"
 * 	found in "../ver2-ulp-components.asn"
 * 	`asn1c -fcompound-names -gen-PER`
 */

#ifndef	_ThirdParty_H_
#define	_ThirdParty_H_


#include <asn_application.h>

/* Including external dependencies */
#include <asn_SEQUENCE_OF.h>
#include <constr_SEQUENCE_OF.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Forward declarations */
struct ThirdPartyID;

/* ThirdParty */
typedef struct ThirdParty {
	A_SEQUENCE_OF(struct ThirdPartyID) list;
	
	/* Context for parsing across buffer boundaries */
	asn_struct_ctx_t _asn_ctx;
} ThirdParty_t;

/* Implementation */
extern asn_TYPE_descriptor_t asn_DEF_ThirdParty;

#ifdef __cplusplus
}
#endif

/* Referred external types */
#include "ThirdPartyID.h"

#endif	/* _ThirdParty_H_ */
#include <asn_internal.h>
