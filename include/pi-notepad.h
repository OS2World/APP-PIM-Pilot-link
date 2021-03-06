#ifndef _PILOT_NOTEPAD_H_
#define _PILOT_NOTEPAD_H_

#include "pi-appinfo.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct NotePadAppInfo {
   int 	dirty,
     sortByPriority;
   struct 	CategoryAppInfo category;
} NotePadAppInfo_t;

typedef struct {
   unsigned short sec;
   unsigned short min;
   unsigned short hour;
   unsigned short day;
   unsigned short month; 
   unsigned short year;
   unsigned short s;      /* Haven't figured this one out - AA */
} noteDate_t;

typedef struct { 
   noteDate_t  createDate;
   noteDate_t  changeDate;
   unsigned short flags;      
} noteHdr_t; 

/* flags */
#define NOTEPAD_FLAG_BODY   0x01
#define NOTEPAD_FLAG_NAME   0x02
#define NOTEPAD_FLAG_ALARM  0x04

/* Actions */
#define NOTEPAD_ACTION_OUTPUT  0x01
#define NOTEPAD_ACTION_LIST    0x02
   
/* Output type */
#define NOTE_OUT_PPM       0x01
#define NOTE_OUT_PNG       0x02
   
/* Data Type */
#define NOTEPAD_DATA_UNCOMPRESSED  0x00     /* OS 4 notepad? */
#define NOTEPAD_DATA_BITS          0x01     /* OS 4 notepad */
#define NOTEPAD_DATA_PNG           0x02     /* OS 5 notepad */
   
/* Note structure
 When flags = 0x03
   noteHdr_t
   char name[0];       NULL termniated and 1 padded to 2 byte boundary
   noteBody_t
 When flags = 0x07
   noteHdr_t
   noteDate_t alarmTime
   char name[0];       NULL termniated and 1 padded to 2 byte boundary
   noteBody_t
*/

			   
typedef struct body {
   unsigned long bodyLen;
   unsigned long width;
   unsigned long height;
   unsigned long l1;		/* 1 ul x ?			*/
   unsigned long dataType;
   unsigned int dataLen;	/* length of dataRecs in bytes	*/
} body_t;
   
typedef struct dataRec {
   unsigned char  repeat;
   unsigned char  data;
} dataRec_t;

typedef struct NotePad {
   noteDate_t  createDate;
   noteDate_t  changeDate;
   unsigned short flags;      
   char *name;
   noteDate_t  alarmDate;
   body_t   body;
   dataRec_t   *data;
} NotePad_t;

void free_NotePad( NotePad_t *a );
int unpack_NotePad(NotePad_t *a, unsigned char *buffer, size_t len);
int unpack_NotePadAppInfo(NotePadAppInfo_t *ai, unsigned char *record,
	size_t len);
int pack_NotePad(NotePad_t *a, unsigned char *buffer, size_t len);
int pack_NotePadAppInfo(NotePadAppInfo_t *ai, unsigned char *record,
	size_t len);

#ifdef __cplusplus
}
#endif				/*__cplusplus*/

#endif
