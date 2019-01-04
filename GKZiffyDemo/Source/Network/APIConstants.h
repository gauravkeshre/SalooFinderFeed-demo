//
//  APIConstants.h
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/28/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//
//https://www.ziffi.com/api/search/


#define HOST @"https://www.ziffi.com/api"
#define API_URL(action) HOST @"/" action

/*
 * ACTION MACRO
 */
#define ACTION_SEARCH   @"search"

/*
 * PARAMS MACRO
 */
#define PARAM_CITY_ID   @"city_id"
#define PARAM_VERTICAL  @"vertical"
#define PARAM_QUERY     @"q"
#define PARAM_PAGE      @"page"


/*
 * PARAMS GEENRATOR
 */
#define API_SEARCH_PARAMS(city_id, vertical, query, page) \
@{PARAM_CITY_ID:city_id, PARAM_VERTICAL:vertical, PARAM_QUERY:query, PARAM_PAGE:page}