#include "tree.h"
void TreeNode::addChild(TreeNode* child) {
    if(this->child==nullptr)
        this->child=child;
    else
    {
        TreeNode* children=this->child;
        
        children->addSibling(child);
    }
}

void TreeNode::addSibling(TreeNode* sibling){
if(this->sibling==nullptr)
        	this->sibling=sibling;
    	else{
    		TreeNode* siblings=this->sibling;
    		while(siblings->sibling!=nullptr)
        		siblings=siblings->sibling;
        	siblings->sibling=sibling;
    	}
}

TreeNode::TreeNode(int lineno, NodeType type) {
this->lineno=lineno;
this->nodeType=type;

}
int preorder(TreeNode* node,int id){
	if(!node)
		return id;
	node->nodeID=id++;
	TreeNode*p;
	for(p=node->child;p;p=p->sibling){
		id=preorder(p,id);	
	}
	return id;
}
void TreeNode::genNodeId() {
preorder(this,0);
}

void TreeNode::printNodeInfo() {
cout<<"  "<<TreeNode::nodeType2String(this->nodeType);
if(this->nodeType==NODE_CONST){
                if(this->type->type==TYPE_INT->type)
		cout<<"   type:int"<<"   value:"<<this->int_val;
		if(this->type->type==TYPE_CHAR->type)
		cout<<"   type:char"<<"   value:'"<<this->int_val<<"'";
		if(this->type->type==TYPE_STRING->type)
		cout<<"   type:string"<<"   value:"<<this->str_val;
}
}

void TreeNode::printChildrenId() {
if(this->child!=nullptr){
        	cout<<"   "<<"children:";
        	TreeNode* children=this->child;
     		while(children!=nullptr){
            		cout<<" "<<children->nodeID;
            		children=children->sibling;
        	}
    	}
}

void TreeNode::printAST() {
cout<<setw(3)<<this->nodeID;
	cout<<setw(3)<<this->lineno;	
	TreeNode::printNodeInfo();
	TreeNode::printChildrenId();
	cout<<endl;

	if(this->child!=nullptr){
        	this->child->printAST();
    	}
	if(this->sibling!=nullptr){
	        this->sibling->printAST();
        }   
}


// You can output more info...
void TreeNode::printSpecialInfo() {
    switch(this->nodeType){
        case NODE_CONST:
            break;
        case NODE_VAR:
            break;
        case NODE_EXPR:
            break;
        case NODE_STMT:
            break;
        case NODE_TYPE:
            break;
        default:
            break;
    }
}

string TreeNode::nodeType2String (NodeType type){
   switch(type){
        case(NODE_CONST):return "const";
        case(NODE_VAR):return "variable";
        case(NODE_EXPR):return "expression";
        case(NODE_TYPE):return "type";
        case(NODE_STMT):return "stmt";
        case(NODE_PROG):return "program";
        case(NODE_BLOCK):return "block";
        default:return"?";
    }
}
