//
//  NKCategoryIcon.m
//  Nepalkhabar
//
//  Created by Bishal Ghimire on 10/07/13.
//  Copyright (c) 2013 BrainDigit. All rights reserved.

/* HOME */
#define HOME1 [category isEqualToString:@"Home"]
#define HOME2 [category isEqualToString:@"Current Affairs"]
#define HOME3 [category isEqualToString:@"मुख्य समाचार"]
#define HOME4 [category isEqualToString:@"समाचार"]
#define HOME5 [category isEqualToString:@"गृहपृष्ठ"]
#define HOME6 [category isEqualToString:@"Top Stories"]
#define HOME @"home"

/* COUNTRY */
#define COUNTRY1 [category isEqualToString:@"Country"]
#define COUNTRY2 [category isEqualToString:@"National"]
#define COUNTRY @"country"

/* ECONOMY */
#define ECONOMY1 [category isEqualToString:@"Economy"]
#define ECONOMY2 [category isEqualToString:@"Bank"]
#define ECONOMY3 [category isEqualToString:@"Business"]
#define ECONOMY4 [category isEqualToString:@"Business And Economy"]
#define ECONOMY5 [category isEqualToString:@"Economy And Tourism"]
#define ECONOMY6 [category isEqualToString:@"अर्थ"]
#define ECONOMY7 [category isEqualToString:@"विजनेश"]
#define ECONOMY8 [category isEqualToString:@"अर्थका कुरा"]
#define ECONOMY @"economics"

/* POLITICS */
#define POLITICS1 [category isEqualToString:@"Politics Society"]
#define POLITICS2 [category isEqualToString:@"Political Affairs"]
#define POLITICS @"politics"

/* INFOTECH */
#define INFOTECH1 [category isEqualToString:@"InfoTech"]
#define INFOTECH2 [category isEqualToString:@"सूचना प्रविधि"]
#define INFOTECH3 [category isEqualToString:@"प्रबिधिका कुरा"]
#define INFOTECH @"technology"

/* OPINION */
#define OPINION1 [category isEqualToString:@"Opinion"]
#define OPINION2 [category isEqualToString:@"Views"]
#define OPINION3 [category isEqualToString:@"Analysis"]
#define OPINION4 [category isEqualToString:@"Editor Pickup"]
#define OPINION5 [category isEqualToString:@"Editorials"]
#define OPINION6 [category isEqualToString:@"बिचार"]
#define OPINION7 [category isEqualToString:@"सम्पादकीय"]
#define OPINION8 [category isEqualToString:@"रिपोर्ट"]
#define OPINION9 [category isEqualToString:@"टिप्पणी"]
#define OPINION10 [category isEqualToString:@"ब्लग"]
#define OPINION @"default"

/* SPORTS */
#define SPORTS1 [category isEqualToString:@"Sports"]
#define SPORTS2 [category isEqualToString:@"खेलकुद"]
#define SPORTS3 [category isEqualToString:@"खेलकुदका कुरा"]
#define SPORTS @"sports"

/* WORLD */
#define WORLD1 [category isEqualToString:@"World"]
#define WORLD2 [category isEqualToString:@"International"]
#define WORLD3 [category isEqualToString:@"विश्व"]
#define WORLD4 [category isEqualToString:@"प्रवास"]
#define WORLD5 [category isEqualToString:@"पर्यटनका कुरा"]
#define WORLD6 [category isEqualToString:@"प्रवासका कुरा"]
#define WORLD @"world"

/* ENTERTAINMENT */
#define ENTERTAINMENT1 [category isEqualToString:@"Entertainment"]
#define ENTERTAINMENT2 [category isEqualToString:@"मनोरंजन"]
#define ENTERTAINMENT3 [category isEqualToString:@"रमझम"]
#define ENTERTAINMENT4 [category isEqualToString:@"विचित्र संसार"]
#define ENTERTAINMENT5 [category isEqualToString:@"मनोरन्जनका कुरा"]
#define ENTERTAINMENT @"entertainment"

/* SOCIAL */
#define SOCIAL1 [category isEqualToString:@"social Affairs"]
#define SOCIAL2 [category isEqualToString:@"समसामयिक कुरा"]
#define SOCIAL3 [category isEqualToString:@"विविध कुरा"]
#define SOCIAL @"social"

/* LIFE */
#define LIFE1 [category isEqualToString:@"Life Style"]
#define LIFE2 [category isEqualToString:@"स्वास्थ्य"]
#define LIFE3 [category isEqualToString:@"व्यक्तित्व"]
#define LIFE @"life"

/* INTERVIEW */
#define INTERVIEW1 [category isEqualToString:@"Interview"]
#define INTERVIEW2 [category isEqualToString:@"कुराकानी"]
#define INTERVIEW3 [category isEqualToString:@"चौतारी"]
#define INTERVIEW4 [category isEqualToString:@"अन्तर्वार्ता -विचार"]
#define INTERVIEW5 [category isEqualToString:@"बिशेष कुरा"]
#define INTERVIEW @"interview"

/* FEATURED */
#define FEATURED1 [category isEqualToString:@"Featured"]
#define FEATURED2 [category isEqualToString:@"साहित्य"]
#define FEATURED @"featured"

/* DOSSIER */
#define DOSSIER1 [category isEqualToString:@"Dossier"]
#define DOSSIER2 [category isEqualToString:@"दस्तावेज"]
#define DOSSIER @"dossier"

#import "NKCategoryIcon.h"

@implementation NKCategoryIcon

- (NSString *)iconForCategory:(NSString *)category {
    NSString *iconName;
    
    if (HOME1 || HOME2 || HOME3 || HOME4 || HOME5 || HOME6) {
        iconName = HOME;
    }
    else if (COUNTRY1 || COUNTRY2) {
        iconName = COUNTRY;
    }
    else if (ECONOMY1 || ECONOMY2 || ECONOMY3 || ECONOMY4 || ECONOMY5 || ECONOMY6 || ECONOMY7 || ECONOMY8) {
        iconName = ECONOMY;
    }
    else if (POLITICS1 || POLITICS2) {
        iconName = POLITICS;
    }
    else if (INFOTECH1 || INFOTECH2 || INFOTECH3) {
        iconName = INFOTECH;
    }
    else if (OPINION1 || OPINION2 || OPINION3 || OPINION4 || OPINION5 || OPINION6 || OPINION7 || OPINION8 || OPINION9||OPINION10) {
        iconName = OPINION;
    }
    else if (SPORTS1 || SPORTS2 || SPORTS3){
        iconName = SPORTS;
    }
    else if (WORLD1 || WORLD2 || WORLD3 || WORLD4 || WORLD5 || WORLD6){
        iconName = WORLD;
    }
    else if (ENTERTAINMENT1 || ENTERTAINMENT2 || ENTERTAINMENT3 || ENTERTAINMENT4 || ENTERTAINMENT5){
        iconName = ENTERTAINMENT;
    }
    else if (SOCIAL1 || SOCIAL2 || SOCIAL3){
        iconName = SOCIAL;
    }
    else if (LIFE1 || LIFE2 || LIFE3){
        iconName = LIFE;
    }
    else if (INTERVIEW1 || INTERVIEW2 || INTERVIEW3 || INTERVIEW4 || INTERVIEW5){
        iconName = INTERVIEW;
    }
    else if(FEATURED1 || FEATURED2){
        iconName = FEATURED;
    }
    else if(DOSSIER1 || DOSSIER2){
        iconName = DOSSIER;
    }
    return  iconName;
}

@end
