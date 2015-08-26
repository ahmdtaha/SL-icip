function [ pb,labelmaps ] = canny_pb( im,thresh,sigma )
%  canny version
im=single(im);
pb=im*0;
count=1;
for t=thresh
    for s=sigma
        cur_edges = single(edge(im,'canny',t,s));
        labelmaps{count}=cur_edges(:);
%         figure(3)
%         imagesc(cur_edges)
%         pause
        pb=pb+cur_edges;
        count=count+1;
    end
end
%linear scale : 0 to 1
low=min(pb(:));
high=max(pb(:));
pb=(pb-low)/(high-low);
end

