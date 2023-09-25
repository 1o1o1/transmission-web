PORTNAME=	transmission
DISTVERSION=	4.0.4
PORTREVISION?=	2
CATEGORIES+=	www
PKGNAMESUFFIX?=	-web

USES=		cpe
NO_ARCH=	yes
NO_BUILD=	yes

MASTER_SITES=	https://github.com/transmission/transmission/archive/

DISTNAME=	3.00

WRKSRC=		${WRKDIR}/${PORTNAME}-${DISTNAME}

MAINTAINER=	admin@freebsd.pp.ua
COMMENT=	Old-Style WebUI for Transmission BitTorrent Daemon (transmission-daemon)

LICENSE+=	MIT

LICENSE+=	GPLv2+
LICENSE_COMB=	multi
LICENSE_FILE=	${WRKSRC}/COPYING

post-extract:
	@${FIND} ${WRKSRC}/web -name .git* -delete

	@${FIND} ${WRKSRC}/web \( -name '*.am' -o -name '*.in' \
		-o -name '*.scss' \) -delete

	@${MV} ${WRKSRC}/web ${WRKSRC}/public_html

do-install:
	( cd ${WRKSRC} && ${COPYTREE_SHARE} public_html ${STAGEDIR}${DATADIR} )

.include <bsd.port.mk>
