/* Copyright (c) 2006-2008 Indiana University Research and Technology Corporation.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, this
 *  list of conditions and the following disclaimer.
 *
 * - Redistributions in binary form must reproduce the above copyright notice,
 *  this list of conditions and the following disclaimer in the documentation
 *  and/or other materials provided with the distribution.
 *
 * - Neither the Indiana University nor the names of its contributors may be used
 *  to endorse or promote products derived from this software without specific
 *  prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */ 
 
/* Ensures that stencil native and python operators are defined in the 
 * ad-hoc module.  Does NOT modify the AST, just populates the ad-hoc module.
 */
tree grammar AdHocOperators;
options {
	tokenVocab = Stencil;
	ASTLabelType = StencilTree;	
	filter = true;
}

@header {
	package stencil.parser.string;

	import stencil.adapters.Adapter;
	import stencil.display.DisplayLayer;
  import stencil.operator.wrappers.EncapsulationGenerator;
  import stencil.operator.*;
  import stencil.operator.module.*;
  import stencil.operator.module.util.*;    
  import stencil.operator.wrappers.*;
  import stencil.parser.tree.*;
}

@members {
	protected MutableModule adHoc;
	protected Adapter adapter;
	EncapsulationGenerator encGenerator = new EncapsulationGenerator();
	
	public AdHocOperators(TreeNodeStream input, ModuleCache modules, Adapter adapter) {
		super(input, new RecognizerSharedState());
		assert modules != null : "Module cache must not be null.";
		assert adapter != null : "Adapter must not be null.";
		
		this.adHoc = modules.getAdHoc();
		this.adapter = adapter;		
	}

	protected void makeOperator(Operator op) {
		DynamicStencilOperator operator = new SyntheticOperator(adHoc.getModuleData().getName(), op);
		
		adHoc.addOperator(operator);
	}
	
	protected void transferProxy(OperatorProxy proxy) {
	  adHoc.addOperator(proxy.getName(), proxy.getOperator(), proxy.getOperatorData()); 
	}	
	
	protected void makePython(Python p) {
		encGenerator.generate(p, adHoc);
	}
	
	protected void makeLayer(Layer l) {
		DisplayLayer dl =adapter.makeLayer(l); 
		l.setDisplayLayer(dl);
		
		DisplayOperator operator = new DisplayOperator(dl);
		adHoc.addOperator(operator, operator.getOperatorData(adHoc.getName()));
	}

	
}
 
topdown
	: ^(r=OPERATOR .*) {makeOperator((Operator) $r);}
	| ^(r=OPERATOR_PROXY .*) {transferProxy((OperatorProxy) $r);}
	| ^(r=PYTHON .*) {makePython((Python) $r);}
	| ^(r=LAYER .*) {makeLayer((Layer) $r);};
