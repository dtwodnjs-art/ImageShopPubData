package com.project.common.domain;

import lombok.Data;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor 
@Data
public class CodeLabelValue {
	private final String value;  //group_code
	private final String label;  //group_name
}
